import 'package:flutter/material.dart';

import '../../../core/database/app_database.dart';
import '../../animals/data/animal_repository.dart';
import '../data/care_repository.dart';

class CareManagementPage extends StatefulWidget {
  const CareManagementPage({
    required this.database,
    required this.workspaceId,
    super.key,
  });

  final AppDatabase database;
  final String workspaceId;

  @override
  State<CareManagementPage> createState() => _CareManagementPageState();
}

class _CareManagementPageState extends State<CareManagementPage> {
  late final CareRepository _care;
  late final AnimalRepository _animals;
  int _view = 0;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _care = CareRepository(widget.database);
    _animals = AnimalRepository(widget.database);
  }

  Future<List<AnimalProfile>> _loadProfiles() {
    return _animals.watchProfiles(widget.workspaceId).first;
  }

  void _message(String value) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(value)),
    );
  }

  Future<void> _addSchedule() async {
    try {
      final profiles = await _loadProfiles();
      if (!mounted) return;
      if (profiles.isEmpty) {
        _message('Buat profil hewan terlebih dahulu.');
        return;
      }
      final draft = await showDialog<_ScheduleDraft>(
        context: context,
        builder: (_) => _ScheduleDialog(profiles: profiles),
      );
      if (draft == null || !mounted) return;

      setState(() => _saving = true);
      await _care.createSchedule(
        workspaceId: widget.workspaceId,
        animalProfileId: draft.profileId,
        title: draft.title,
        careType: draft.type,
        recurrenceType: draft.recurrence,
        intervalDays: draft.intervalDays,
        scheduledAt: draft.scheduledAt,
        instructions: draft.instructions,
      );
      if (mounted) _message('Jadwal tersimpan di perangkat.');
    } catch (error) {
      if (mounted) _message('Gagal menyimpan jadwal: $error');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _addRecord() async {
    try {
      final profiles = await _loadProfiles();
      if (!mounted) return;
      if (profiles.isEmpty) {
        _message('Buat profil hewan terlebih dahulu.');
        return;
      }
      final draft = await showDialog<_RecordDraft>(
        context: context,
        builder: (_) => _RecordDialog(profiles: profiles),
      );
      if (draft == null || !mounted) return;

      setState(() => _saving = true);
      await _care.recordCare(
        workspaceId: widget.workspaceId,
        animalProfileId: draft.profileId,
        title: draft.title,
        careType: draft.type,
        quantityValue: draft.quantity,
        quantityUnit: draft.unit,
        notes: draft.notes,
      );
      if (mounted) _message('Aktivitas berhasil dicatat.');
    } catch (error) {
      if (mounted) _message('Gagal mencatat aktivitas: $error');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _complete(CareScheduleEntry entry) async {
    try {
      setState(() => _saving = true);
      await _care.completeSchedule(
        workspaceId: widget.workspaceId,
        scheduleId: entry.schedule.id,
      );
      if (mounted) {
        _message(
          entry.schedule.recurrenceType == 'once'
              ? 'Jadwal selesai dan masuk ke riwayat.'
              : 'Aktivitas dicatat dan jadwal berikutnya diperbarui.',
        );
      }
    } catch (error) {
      if (mounted) _message('Gagal menyelesaikan jadwal: $error');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _archive(CareSchedule schedule) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Arsipkan jadwal?'),
        content: Text(
          'Jadwal "${schedule.title}" akan dihentikan. Riwayat aktivitas tetap disimpan.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Arsipkan'),
          ),
        ],
      ),
    );
    if (confirm != true || !mounted) return;
    try {
      await _care.archiveSchedule(
        workspaceId: widget.workspaceId,
        scheduleId: schedule.id,
      );
      if (mounted) _message('Jadwal berhasil diarsipkan.');
    } catch (error) {
      if (mounted) _message('Gagal mengarsipkan jadwal: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return StreamBuilder<List<CareScheduleEntry>>(
      stream: _care.watchSchedules(widget.workspaceId),
      builder: (context, scheduleSnapshot) {
        final schedules = scheduleSnapshot.data ?? const <CareScheduleEntry>[];
        return StreamBuilder<List<CareRecordEntry>>(
          stream: _care.watchRecords(widget.workspaceId),
          builder: (context, recordSnapshot) {
            final records = recordSnapshot.data ?? const <CareRecordEntry>[];
            final activeCount =
                schedules.where((item) => item.schedule.isActive).length;

            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(22, 25, 22, 34),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1120),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'RUTINITAS DAN PERAWATAN',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: colors.primary,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1.1,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Jadwal perawatan',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                      const SizedBox(height: 7),
                      Text(
                        'Atur rutinitas setiap hewan dan catat aktivitas yang benar-benar dilakukan.',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: colors.onSurfaceVariant,
                            ),
                      ),
                      const SizedBox(height: 20),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          _SummaryTile(
                            icon: Icons.event_repeat_rounded,
                            label: 'Jadwal aktif',
                            value: activeCount.toString(),
                          ),
                          _SummaryTile(
                            icon: Icons.history_rounded,
                            label: 'Aktivitas tercatat',
                            value: records.length.toString(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          FilledButton.icon(
                            onPressed: _saving ? null : _addSchedule,
                            icon: const Icon(Icons.add_rounded),
                            label: const Text('Buat jadwal perawatan'),
                          ),
                          OutlinedButton.icon(
                            onPressed: _saving ? null : _addRecord,
                            icon: const Icon(Icons.note_add_outlined),
                            label: const Text('Catat aktivitas'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SegmentedButton<int>(
                        segments: const [
                          ButtonSegment(
                            value: 0,
                            label: Text('Jadwal'),
                            icon: Icon(Icons.calendar_month_outlined),
                          ),
                          ButtonSegment(
                            value: 1,
                            label: Text('Riwayat aktivitas'),
                            icon: Icon(Icons.history_rounded),
                          ),
                        ],
                        selected: {_view},
                        showSelectedIcon: false,
                        onSelectionChanged: (values) {
                          setState(() => _view = values.first);
                        },
                      ),
                      const SizedBox(height: 15),
                      if (_view == 0)
                        _scheduleContent(scheduleSnapshot, schedules)
                      else
                        _recordContent(recordSnapshot, records),
                      const SizedBox(height: 17),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: colors.surfaceContainerLow,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.cloud_off_outlined, color: colors.primary),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Data perawatan disimpan secara lokal. Perubahan masuk ke antrean sinkronisasi; layanan cloud belum dikonfigurasi.',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: colors.onSurfaceVariant,
                                      height: 1.45,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _scheduleContent(
    AsyncSnapshot<List<CareScheduleEntry>> snapshot,
    List<CareScheduleEntry> entries,
  ) {
    if (snapshot.hasError) {
      return _EmptyPanel(
        icon: Icons.error_outline,
        title: 'Jadwal tidak dapat dibaca',
        message: snapshot.error.toString(),
      );
    }
    if (snapshot.connectionState == ConnectionState.waiting && entries.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(35),
          child: CircularProgressIndicator(),
        ),
      );
    }
    if (entries.isEmpty) {
      return const _EmptyPanel(
        icon: Icons.calendar_month_outlined,
        title: 'Belum ada jadwal perawatan',
        message:
            'Buat jadwal pemberian pakan, pembersihan, grooming, obat, pemeriksaan, atau rutinitas lainnya.',
      );
    }

    final active = entries.where((item) => item.schedule.isActive).toList();
    final finished = entries.where((item) => !item.schedule.isActive).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (active.isNotEmpty) ...[
          const _SectionLabel('JADWAL BERJALAN'),
          const SizedBox(height: 9),
          for (final entry in active)
            _ScheduleTile(
              entry: entry,
              onComplete: _saving ? null : () => _complete(entry),
              onArchive: () => _archive(entry.schedule),
            ),
        ],
        if (finished.isNotEmpty) ...[
          const SizedBox(height: 14),
          const _SectionLabel('JADWAL SELESAI'),
          const SizedBox(height: 9),
          for (final entry in finished)
            _ScheduleTile(entry: entry, readOnly: true),
        ],
      ],
    );
  }

  Widget _recordContent(
    AsyncSnapshot<List<CareRecordEntry>> snapshot,
    List<CareRecordEntry> entries,
  ) {
    if (snapshot.hasError) {
      return _EmptyPanel(
        icon: Icons.error_outline,
        title: 'Riwayat tidak dapat dibaca',
        message: snapshot.error.toString(),
      );
    }
    if (snapshot.connectionState == ConnectionState.waiting && entries.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(35),
          child: CircularProgressIndicator(),
        ),
      );
    }
    if (entries.isEmpty) {
      return const _EmptyPanel(
        icon: Icons.history_rounded,
        title: 'Belum ada aktivitas tercatat',
        message:
            'Aktivitas dari jadwal yang diselesaikan dan catatan manual akan ditampilkan di sini.',
      );
    }
    return Column(
      children: [
        for (final entry in entries) _RecordTile(entry: entry),
        if (entries.length >= 100)
          const Padding(
            padding: EdgeInsets.all(8),
            child: Text('Menampilkan 100 aktivitas terbaru.'),
          ),
      ],
    );
  }
}

class _ScheduleTile extends StatelessWidget {
  const _ScheduleTile({
    required this.entry,
    this.onComplete,
    this.onArchive,
    this.readOnly = false,
  });

  final CareScheduleEntry entry;
  final VoidCallback? onComplete;
  final VoidCallback? onArchive;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    final schedule = entry.schedule;
    final colors = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: colors.primaryContainer,
                  foregroundColor: colors.onPrimaryContainer,
                  child: Icon(_careIcon(schedule.careType)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        schedule.title,
                        style: const TextStyle(fontWeight: FontWeight.w800),
                      ),
                      Text(
                        entry.profile.displayName,
                        style: TextStyle(color: colors.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
                if (!schedule.isActive)
                  const Chip(label: Text('Selesai')),
              ],
            ),
            const SizedBox(height: 9),
            Wrap(
              spacing: 7,
              runSpacing: 6,
              children: [
                _SmallTag(_careTypeLabel(schedule.careType)),
                _SmallTag(_recurrenceLabel(
                  schedule.recurrenceType,
                  schedule.intervalDays,
                )),
              ],
            ),
            const SizedBox(height: 9),
            Text(
              schedule.isActive
                  ? 'Berikutnya: ${_dateTime(schedule.nextDueAt)}'
                  : 'Terakhir selesai: ${schedule.lastCompletedAt == null ? '-' : _dateTime(schedule.lastCompletedAt!)}',
              style: TextStyle(
                color: colors.onSurfaceVariant,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (schedule.instructions != null &&
                schedule.instructions!.isNotEmpty) ...[
              const SizedBox(height: 6),
              Text(schedule.instructions!),
            ],
            if (!readOnly) ...[
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                children: [
                  FilledButton.tonalIcon(
                    onPressed: onComplete,
                    icon: const Icon(Icons.check_rounded, size: 18),
                    label: const Text('Tandai selesai'),
                  ),
                  TextButton.icon(
                    onPressed: onArchive,
                    icon: const Icon(Icons.archive_outlined, size: 18),
                    label: const Text('Arsipkan'),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _RecordTile extends StatelessWidget {
  const _RecordTile({required this.entry});

  final CareRecordEntry entry;

  @override
  Widget build(BuildContext context) {
    final record = entry.record;
    final colors = Theme.of(context).colorScheme;
    final amount = record.quantityValue == null || record.quantityUnit == null
        ? null
        : '${_number(record.quantityValue!)} ${record.quantityUnit}';

    return Card(
      margin: const EdgeInsets.only(bottom: 9),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
        leading: CircleAvatar(
          backgroundColor: colors.secondaryContainer,
          foregroundColor: colors.onSecondaryContainer,
          child: Icon(_careIcon(record.careType)),
        ),
        title: Text(
          record.title,
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${entry.profile.displayName} · ${_careTypeLabel(record.careType)}'),
              Text(_dateTime(record.performedAt)),
              if (amount != null) Text('Takaran: $amount'),
              if (record.notes != null && record.notes!.isNotEmpty)
                Text(record.notes!),
            ],
          ),
        ),
      ),
    );
  }
}

class _ScheduleDialog extends StatefulWidget {
  const _ScheduleDialog({required this.profiles});

  final List<AnimalProfile> profiles;

  @override
  State<_ScheduleDialog> createState() => _ScheduleDialogState();
}

class _ScheduleDialogState extends State<_ScheduleDialog> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _instructions = TextEditingController();
  final _interval = TextEditingController();
  late String _profileId;
  String _type = 'feeding';
  String _recurrence = 'daily';
  DateTime _start = DateTime.now();

  @override
  void initState() {
    super.initState();
    _profileId = widget.profiles.first.id;
  }

  @override
  void dispose() {
    _title.dispose();
    _instructions.dispose();
    _interval.dispose();
    super.dispose();
  }

  Future<void> _pickStart() async {
    final day = await showDatePicker(
      context: context,
      initialDate: _start,
      firstDate: DateTime(1900),
      lastDate: DateTime(2200),
    );
    if (day == null || !mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_start),
    );
    if (time == null || !mounted) return;
    setState(() {
      _start = DateTime(day.year, day.month, day.day, time.hour, time.minute);
    });
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final days = _recurrence == 'interval'
        ? int.tryParse(_interval.text.trim())
        : null;
    Navigator.pop(
      context,
      _ScheduleDraft(
        profileId: _profileId,
        title: _title.text.trim(),
        type: _type,
        recurrence: _recurrence,
        intervalDays: days,
        scheduledAt: _start,
        instructions: _instructions.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Buat jadwal perawatan'),
      content: SizedBox(
        width: 440,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  initialValue: _profileId,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    labelText: 'Profil hewan *',
                    border: OutlineInputBorder(),
                  ),
                  items: [
                    for (final profile in widget.profiles)
                      DropdownMenuItem(
                        value: profile.id,
                        child: Text(profile.displayName),
                      ),
                  ],
                  onChanged: (value) {
                    if (value != null) setState(() => _profileId = value);
                  },
                ),
                const SizedBox(height: 11),
                TextFormField(
                  controller: _title,
                  decoration: const InputDecoration(
                    labelText: 'Nama kegiatan *',
                    hintText: 'Contoh: Pakan pagi',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value == null || value.trim().isEmpty
                      ? 'Nama kegiatan wajib diisi.'
                      : null,
                ),
                const SizedBox(height: 11),
                DropdownButtonFormField<String>(
                  initialValue: _type,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    labelText: 'Jenis perawatan',
                    border: OutlineInputBorder(),
                  ),
                  items: [
                    for (final value in CareRepository.careTypes)
                      DropdownMenuItem(
                        value: value,
                        child: Text(_careTypeLabel(value)),
                      ),
                  ],
                  onChanged: (value) {
                    if (value != null) setState(() => _type = value);
                  },
                ),
                const SizedBox(height: 11),
                DropdownButtonFormField<String>(
                  initialValue: _recurrence,
                  decoration: const InputDecoration(
                    labelText: 'Pengulangan',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'once', child: Text('Sekali saja')),
                    DropdownMenuItem(value: 'daily', child: Text('Setiap hari')),
                    DropdownMenuItem(value: 'weekly', child: Text('Setiap minggu')),
                    DropdownMenuItem(value: 'interval', child: Text('Setiap beberapa hari')),
                  ],
                  onChanged: (value) {
                    if (value != null) setState(() => _recurrence = value);
                  },
                ),
                if (_recurrence == 'interval') ...[
                  const SizedBox(height: 11),
                  TextFormField(
                    controller: _interval,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Interval hari *',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (_recurrence != 'interval') return null;
                      final days = int.tryParse(value?.trim() ?? '');
                      return days == null || days < 1 || days > 365
                          ? 'Isi 1 sampai 365 hari.'
                          : null;
                    },
                  ),
                ],
                const SizedBox(height: 10),
                OutlinedButton.icon(
                  onPressed: _pickStart,
                  icon: const Icon(Icons.event_outlined),
                  label: Text('Mulai: ${_dateTime(_start)}'),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _instructions,
                  minLines: 2,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Instruksi (opsional)',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
        FilledButton(
          onPressed: _submit,
          child: const Text('Simpan jadwal'),
        ),
      ],
    );
  }
}

class _RecordDialog extends StatefulWidget {
  const _RecordDialog({required this.profiles});

  final List<AnimalProfile> profiles;

  @override
  State<_RecordDialog> createState() => _RecordDialogState();
}

class _RecordDialogState extends State<_RecordDialog> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _quantity = TextEditingController();
  final _unit = TextEditingController();
  final _notes = TextEditingController();
  late String _profileId;
  String _type = 'feeding';

  @override
  void initState() {
    super.initState();
    _profileId = widget.profiles.first.id;
  }

  @override
  void dispose() {
    _title.dispose();
    _quantity.dispose();
    _unit.dispose();
    _notes.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final amountText = _quantity.text.trim();
    final unit = _unit.text.trim();
    final amount = amountText.isEmpty ? null : double.tryParse(amountText);
    if ((amountText.isEmpty) != unit.isEmpty ||
        (amountText.isNotEmpty && amount == null)) {
      return;
    }
    Navigator.pop(
      context,
      _RecordDraft(
        profileId: _profileId,
        title: _title.text.trim(),
        type: _type,
        quantity: amount,
        unit: unit.isEmpty ? null : unit,
        notes: _notes.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Catat aktivitas perawatan'),
      content: SizedBox(
        width: 440,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  initialValue: _profileId,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    labelText: 'Profil hewan *',
                    border: OutlineInputBorder(),
                  ),
                  items: [
                    for (final profile in widget.profiles)
                      DropdownMenuItem(
                        value: profile.id,
                        child: Text(profile.displayName),
                      ),
                  ],
                  onChanged: (value) {
                    if (value != null) setState(() => _profileId = value);
                  },
                ),
                const SizedBox(height: 11),
                DropdownButtonFormField<String>(
                  initialValue: _type,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    labelText: 'Jenis aktivitas',
                    border: OutlineInputBorder(),
                  ),
                  items: [
                    for (final value in CareRepository.careTypes)
                      DropdownMenuItem(
                        value: value,
                        child: Text(_careTypeLabel(value)),
                      ),
                  ],
                  onChanged: (value) {
                    if (value != null) setState(() => _type = value);
                  },
                ),
                const SizedBox(height: 11),
                TextFormField(
                  controller: _title,
                  decoration: const InputDecoration(
                    labelText: 'Nama aktivitas *',
                    hintText: 'Contoh: Pemberian pakan pagi',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value == null || value.trim().isEmpty
                      ? 'Nama aktivitas wajib diisi.'
                      : null,
                ),
                const SizedBox(height: 11),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _quantity,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        decoration: const InputDecoration(
                          labelText: 'Takaran',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 9),
                    Expanded(
                      child: TextFormField(
                        controller: _unit,
                        decoration: const InputDecoration(
                          labelText: 'Satuan',
                          hintText: 'gram, ml',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 11),
                TextFormField(
                  controller: _notes,
                  minLines: 2,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Catatan',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
        FilledButton(
          onPressed: _submit,
          child: const Text('Simpan aktivitas'),
        ),
      ],
    );
  }
}

class _ScheduleDraft {
  const _ScheduleDraft({
    required this.profileId,
    required this.title,
    required this.type,
    required this.recurrence,
    required this.intervalDays,
    required this.scheduledAt,
    required this.instructions,
  });

  final String profileId;
  final String title;
  final String type;
  final String recurrence;
  final int? intervalDays;
  final DateTime scheduledAt;
  final String instructions;
}

class _RecordDraft {
  const _RecordDraft({
    required this.profileId,
    required this.title,
    required this.type,
    required this.quantity,
    required this.unit,
    required this.notes,
  });

  final String profileId;
  final String title;
  final String type;
  final double? quantity;
  final String? unit;
  final String notes;
}

class _SummaryTile extends StatelessWidget {
  const _SummaryTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      constraints: const BoxConstraints(minWidth: 180),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.outlineVariant),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: colors.primary),
          const SizedBox(width: 9),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SmallTag extends StatelessWidget {
  const _SmallTag(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: colors.onSurfaceVariant,
            ),
      ),
    );
  }
}

class _EmptyPanel extends StatelessWidget {
  const _EmptyPanel({
    required this.icon,
    required this.title,
    required this.message,
  });

  final IconData icon;
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 32),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: colors.outlineVariant),
      ),
      child: Column(
        children: [
          Icon(icon, size: 38, color: colors.primary),
          const SizedBox(height: 12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 7),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 540),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colors.onSurfaceVariant,
                    height: 1.5,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
            letterSpacing: 0.8,
            fontWeight: FontWeight.w800,
          ),
    );
  }
}

IconData _careIcon(String type) {
  return switch (type) {
    'feeding' => Icons.restaurant_outlined,
    'cleaning' => Icons.cleaning_services_outlined,
    'grooming' => Icons.content_cut_rounded,
    'medication' => Icons.medication_outlined,
    'exercise' => Icons.directions_run_rounded,
    'health_check' => Icons.health_and_safety_outlined,
    'measurement' => Icons.straighten_rounded,
    'enrichment' => Icons.extension_rounded,
    _ => Icons.event_note_outlined,
  };
}

String _careTypeLabel(String type) {
  return switch (type) {
    'feeding' => 'Pemberian pakan',
    'cleaning' => 'Pembersihan',
    'grooming' => 'Grooming',
    'medication' => 'Pemberian obat',
    'exercise' => 'Aktivitas fisik',
    'health_check' => 'Pemeriksaan',
    'measurement' => 'Pengukuran',
    'enrichment' => 'Pengayaan lingkungan',
    _ => 'Lainnya',
  };
}

String _recurrenceLabel(String type, int? intervalDays) {
  return switch (type) {
    'once' => 'Sekali',
    'daily' => 'Harian',
    'weekly' => 'Mingguan',
    'interval' => 'Setiap $intervalDays hari',
    _ => type,
  };
}

String _dateTime(DateTime value) {
  final date = value.toLocal();
  final day = date.day.toString().padLeft(2, '0');
  final month = date.month.toString().padLeft(2, '0');
  final hour = date.hour.toString().padLeft(2, '0');
  final minute = date.minute.toString().padLeft(2, '0');
  return '$day/$month/${date.year} $hour:$minute';
}

String _number(double value) {
  return value == value.roundToDouble()
      ? value.toInt().toString()
      : value.toString();
}
