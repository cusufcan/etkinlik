import 'dart:io';

import 'package:etkinlik/base/constant/app_num.dart';
import 'package:etkinlik/base/constant/app_string.dart';
import 'package:etkinlik/base/helper/messenger.dart';
import 'package:etkinlik/base/widget/custom_card.dart';
import 'package:etkinlik/feature/event_create/widget/event_button.dart';
import 'package:etkinlik/feature/event_create/widget/event_field.dart';
import 'package:etkinlik/feature/event_create/widget/event_image.dart';
import 'package:etkinlik/feature/location_pick/location_pick_view.dart';
import 'package:etkinlik/model/event.dart';
import 'package:etkinlik/provider/event_provider.dart';
import 'package:etkinlik/provider/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:map_location_picker/map_location_picker.dart';
import 'package:uuid/uuid.dart';

part 'event_create_view_model.dart';

class EventCreateView extends ConsumerStatefulWidget {
  const EventCreateView({super.key});

  @override
  ConsumerState<EventCreateView> createState() => _EventCreateViewState();
}

class _EventCreateViewState extends _EventCreateViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Etkinlik Oluştur'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppNum.small),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              EventImage(
                isLoading: _isLoading,
                onImageSelected: (image) {
                  _selectedImage = image;
                },
              ),
              const SizedBox(height: AppNum.xSmall),
              CustomCard(
                padding: const EdgeInsets.all(AppNum.xSmall),
                child: Padding(
                  padding: const EdgeInsets.all(AppNum.xSmall),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      EventField(
                        enabled: !_isLoading,
                        label: 'Başlık',
                        onSaved: (value) {
                          _title = value!;
                        },
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Başlık boş olamaz.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: AppNum.medium),
                      EventField(
                        enabled: !_isLoading,
                        keyboardType: TextInputType.number,
                        label: 'Kapasite (Max: 50)',
                        onSaved: (value) {
                          _capacity = int.parse(value!);
                        },
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Kapasite boş olamaz.';
                          }
                          if (int.tryParse(value) == null ||
                              int.tryParse(value)! < 1) {
                            return 'Kapasite sayı olmalıdır.';
                          }
                          if (int.tryParse(value)! > 50) {
                            return 'Kapasite en fazla 50 olmalıdır.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: AppNum.medium),
                      EventField(
                        enabled: !_isLoading,
                        label: 'Açıklama',
                        onSaved: (value) {
                          if (value != null && value.trim().isNotEmpty) {
                            _description = value;
                          } else {
                            _description = 'Açıklama yok.';
                          }
                        },
                      ),
                      const SizedBox(height: AppNum.medium),
                      EventButton(
                        maxLines: 5,
                        label: _location == null ? 'Konum Seç' : _location!,
                        onPressed: _isLoading ? null : _pickLocation,
                        icon: _location == null
                            ? const Icon(Icons.location_on_outlined)
                            : null,
                      ),
                      const SizedBox(height: AppNum.medium),
                      Row(
                        children: [
                          Expanded(
                            child: EventButton(
                              label: _date == null ? 'Tarih Seç' : _date!,
                              onPressed: _isLoading ? null : _pickDate,
                              icon: const Icon(Icons.date_range_outlined),
                            ),
                          ),
                          const SizedBox(width: AppNum.small),
                          Expanded(
                            child: EventButton(
                              label: _time == null ? 'Saat Seç' : _time!,
                              onPressed: _isLoading ? null : _pickTime,
                              icon: const Icon(Icons.access_time_outlined),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppNum.xSmall),
              Padding(
                padding: const EdgeInsets.all(AppNum.xxSmall),
                child: EventButton(
                  label: 'Oluştur',
                  onPressed: _isLoading ? null : _submit,
                  icon: const Icon(Icons.check_circle_outlined),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
