import 'dart:developer';

import 'package:wedding/repositories.dart';

class RegisterViewModel extends ViewModel {
  late SweetDialog loading;
  late ApiProvider apiProvider;

  bool _isReservasion = false;
  bool get isReservasion => _isReservasion;
  set isReservasion(bool value) {
    _isReservasion = value;
    notifyListeners();
  }

  List<SessionModel> _sessions = List<SessionModel>.empty(growable: true);
  List<SessionModel> get sessions => _sessions;
  set sessions(List<SessionModel> value) {
    _sessions = value;
    notifyListeners();
  }

  int _invitationID = 0;
  int get invitationID => _invitationID;
  set invitationID(int value) {
    _invitationID = value;
    notifyListeners();
  }

  int _reservasionID = 0;
  int get reservasionID => _reservasionID;
  set reservasionID(int value) {
    _reservasionID = value;
    notifyListeners();
  }

  String _userName = '';
  String get userName => _userName;
  set userName(String value) {
    _userName = value;
    notifyListeners();
  }

  String _selectedSession = '';
  String get selectedSession => _selectedSession;
  set selectedSession(String value) {
    _selectedSession = value;
    notifyListeners();
  }

  String _selectedSessionName = '';
  String get selectedSessionName => _selectedSessionName;
  set selectedSessionName(String value) {
    _selectedSessionName = value;
    notifyListeners();
  }

  String _phoneNumber = '';
  String get phoneNumber => _phoneNumber;
  set phoneNumber(String value) {
    _phoneNumber = value;
    notifyListeners();
  }

  List<MemberModel> _members = List<MemberModel>.empty(growable: true);
  List<MemberModel> get members => _members;
  set members(List<MemberModel> value) {
    _members = value;
    notifyListeners();
  }

  List<String> nickname = [
    'Bpk',
    'Ibu',
    'Tuan/Mr',
    'Nona',
    'Ananda (0-6tahun)',
  ];

  var newMamberName = '';

  void writeMemberName(int indexMember, String initialValue) {
    newMamberName = initialValue;
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      constraints: const BoxConstraints(maxWidth: 475),
      isScrollControlled: true,
      backgroundColor: Colors.white,
      context: context,
      builder: ((context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.only(
                    bottom: 24,
                    top: 16,
                  ),
                  height: 4,
                  width: 80,
                  decoration: const BoxDecoration(
                    color: IColors.neutral20,
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                  ),
                ),
              ),
              Text(
                'Silahkan ketik nama lengkap',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: IColors.gray800,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'OpenSans',
                    ),
              ),
              const SizedBox(height: 16),
              InputFormText(
                initialValue: initialValue,
                height: 50,
                padding: const EdgeInsets.only(
                  left: 0,
                  right: 0,
                ),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                onChanged: (value) => newMamberName = value,
                hintText: 'Masukkan nama lengkap',
                prefixIcon: Container(
                  height: 50,
                  color: IColors.pink50,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 13,
                  ),
                  margin: const EdgeInsets.only(right: 8),
                  child: const Icon(
                    Icons.person_outline_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 50,
                child: ButtonPrimary(
                  text: 'Simpan',
                  onPressed: () {
                    updateMemberName(newMamberName, indexMember);
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  void showNicknameDialog(int indexMember) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      constraints: const BoxConstraints(maxWidth: 475),
      isScrollControlled: true,
      backgroundColor: Colors.white,
      context: context,
      builder: ((context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.only(
                    bottom: 24,
                    top: 16,
                  ),
                  height: 4,
                  width: 80,
                  decoration: const BoxDecoration(
                    color: IColors.neutral20,
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                  ),
                ),
              ),
              Text(
                'Silahkan pilih nama panggilan',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: IColors.gray800,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'OpenSans',
                    ),
              ),
              const SizedBox(height: 16),
              ListView.builder(
                key: UniqueKey(),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: nickname.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    splashFactory: NoSplash.splashFactory,
                    hoverColor: Colors.transparent,
                    onTap: () {
                      members[indexMember].nickname = nickname[index];
                      members = members;
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 6),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: IColors.gray50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        nickname[index],
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              color: IColors.black80,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'OpenSans',
                            ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      }),
    );
  }

  void showSessionList() {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      constraints: const BoxConstraints(maxWidth: 475),
      isScrollControlled: true,
      backgroundColor: Colors.white,
      context: context,
      builder: ((context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.only(
                    bottom: 24,
                    top: 16,
                  ),
                  height: 4,
                  width: 80,
                  decoration: const BoxDecoration(
                    color: IColors.neutral20,
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                  ),
                ),
              ),
              Text(
                'Silahkan pilih sesi',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: IColors.gray800,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'OpenSans',
                    ),
              ),
              const SizedBox(height: 16),
              ListView.builder(
                key: UniqueKey(),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: sessions.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    splashFactory: NoSplash.splashFactory,
                    hoverColor: Colors.transparent,
                    onTap: () {
                      selectedSession = sessions[index].sessionID!;
                      selectedSessionName =
                          'Sesi ${sessions[index].sessionName} (${sessions[index].sessionStart} sd ${sessions[index].sessionEnd}) ${sessions[index].sessionQuota} kuota tersisa';
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 6),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: selectedSession == sessions[index].sessionID
                            ? IColors.gray50
                            : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Sesi ${sessions[index].sessionName} (${sessions[index].sessionStart} sd ${sessions[index].sessionEnd}) ${sessions[index].sessionQuota} kuota tersisa',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              color: IColors.black80,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'OpenSans',
                            ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      }),
    );
  }

  void updateMemberName(String value, int index) {
    members[index].memberName = value;
    members = members;
  }

  void addNewMember() {
    // check if member name is empty
    if (members.isEmpty) {
      List<MemberModel> list = [MemberModel(memberID: '${members.length + 1}')];
      members = list;
    } else {
      if (members[members.length - 1].memberName == null ||
          members[members.length - 1].nickname == null) {
        SweetDialog(
          context: context,
          title: 'Nama dan panggilan harus diisi',
          content: 'Silahkan isi nama dan panggilan terlebih dahulu',
          dialogType: SweetDialogType.error,
        ).show();
      } else {
        List<MemberModel> list = members;
        list.add(MemberModel(memberID: '${members.length + 1}'));
        members = list;
      }
    }
  }

  void removeMember(int index) {
    var list = members;
    list.removeAt(index);

    members = list;
    // members.removeAt(index);
    // members = members;
  }

  void successCreateReservasion() {
    SweetDialog(
      context: context,
      title: 'Berhasil membuat reservasi',
      content:
          'Reservasi berhasil dibuat, silahkan lanjutkan untuk memesan makanan',
      dialogType: SweetDialogType.success,
      barrierDismissible: false,
      confirmText: 'Lanjutkan',
      onConfirm: () {
        Get.toNamed('/menus', arguments: {
          'userName': userName,
          'reservasionID': reservasionID,
          'sessionID': selectedSession,
        });
      },
    ).show();
  }

  void addMember(List<MemberModel> members, int reservasionID) async {
    // List<String> memberNames = List.from(members.map((e) => e.memberName!));
    await apiProvider
        .addMember(
            reservasionID: reservasionID,
            sessionID: selectedSession,
            members: members)
        .then(
      (value) {
        loading.dismiss();
        successCreateReservasion();
      },
      onError: (e) {
        loading.dismiss();
        SweetDialog(
          context: context,
          title: 'Gagal menambahkan anggota',
          content: e.toString(),
          dialogType: SweetDialogType.error,
        ).show();
      },
    );
  }

  void createReservasion() async {
    loading.show();
    if (isReservasion) {
      addMember(members, reservasionID);
    } else {
      await apiProvider
          .createReservasion(
              name: userName, phoneNumber: phoneNumber, id: invitationID)
          .then(
        (value) {
          isReservasion = true;
          reservasionID = value;
          if (members.isNotEmpty) {
            addMember(members, value);
          } else {
            loading.dismiss();
            successCreateReservasion();
          }
        },
        onError: (e) {
          loading.dismiss();
          SweetDialog(
            context: context,
            title: 'Gagal membuat reservasi',
            content: e.toString(),
            dialogType: SweetDialogType.error,
          ).show();
        },
      );
    }
  }

  void chooseFoods() {
    if (selectedSession.isEmpty) {
      SweetDialog(
        context: context,
        title: 'Belum memilih sesi',
        content: 'Silahkan pilih sesi terlebih dahulu',
        dialogType: SweetDialogType.error,
      ).show();
      return;
    }

    if (members.isEmpty) {
      SweetDialog(
        context: context,
        title: 'Belum menambahkan anggota',
        content: 'Silahkan tambahkan setidaknya 1 anggota, yaitu anda sendiri',
        dialogType: SweetDialogType.error,
      ).show();
      return;
    }

    createReservasion();
  }

  void getDataSession() async {
    loading.show();
    await apiProvider.getSessions().then((value) {
      sessions = value;
      loading.dismiss();
    }, onError: (e) {
      loading.dismiss();
      SweetDialog(
        context: context,
        title: 'Terjadi kesalahan',
        content: 'Tidak dapat mengambil data sesi',
        dialogType: SweetDialogType.error,
        barrierDismissible: false,
        onConfirm: () => Get.back(),
      ).show();
    });
  }

  void userNotFound() {
    SweetDialog(
      context: context,
      title: 'Oops!',
      content: 'Tidak dapat menemukan data tamu',
      dialogType: SweetDialogType.error,
      barrierDismissible: false,
      confirmText: 'Kembali',
      onConfirm: () => Get.toNamed('/rsvp'),
    ).show();
  }

  @override
  void init() {
    apiProvider = getApiProvider;
    loading = SweetDialog(
      context: context,
      dialogType: SweetDialogType.loading,
      barrierDismissible: false,
    );

    try {
      final args = Get.arguments;
      if (args != null) {
        userName = args['userName'];
        phoneNumber = args['phoneNumber'];
        invitationID = args['invitationID'] ?? 0;
        Future.delayed(Duration.zero, () {
          getDataSession();
        });
      } else {
        Future.delayed(Duration.zero, () {
          userNotFound();
        });
      }
    } catch (e) {
      log(e.toString());
      Future.delayed(Duration.zero, () {
        userNotFound();
      });
    }
  }

  @override
  void onDependenciesChange() {}

  @override
  void onBuild() {}

  @override
  void onMount() {}

  @override
  void onUnmount() {}

  @override
  void onResume() {}

  @override
  void onPause() {}

  @override
  void onInactive() {}

  @override
  void onDetach() {}
}
