class LoginResponse {
  bool? success;
  String? msg;
  String? code;
  String? myOtp;
  List<Data>? data;
  List<Vehicledata>? vehicledata;

  LoginResponse(
      {this.success,
        this.msg,
        this.code,
        this.myOtp,
        this.data,
        this.vehicledata});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    success = json['Success'];
    msg = json['Msg'];
    code = json['Code'];
    myOtp = json['MyOtp'];
    if (json['Data'] != null) {
      data = <Data>[];
      json['Data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    if (json['Vehicledata'] != null) {
      vehicledata = <Vehicledata>[];
      json['Vehicledata'].forEach((v) {
        vehicledata!.add(new Vehicledata.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Success'] = this.success;
    data['Msg'] = this.msg;
    data['Code'] = this.code;
    data['MyOtp'] = this.myOtp;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.vehicledata != null) {
      data['Vehicledata'] = this.vehicledata!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? personName;
  String? contactno;
  String? latitude;
  String? longitude;
  String? status;
  String? alternetNo;
  String? emailid;
  String? userType;
  String? userImg;
  String? createdate;
  String? myRefercode;
  Null? dob;
  Null? gender;

  Data(
      {this.id,
        this.personName,
        this.contactno,
        this.latitude,
        this.longitude,
        this.status,
        this.alternetNo,
        this.emailid,
        this.userType,
        this.userImg,
        this.createdate,
        this.myRefercode,
        this.dob,
        this.gender});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    personName = json['personName'];
    contactno = json['contactno'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    status = json['status'];
    alternetNo = json['alternet_no'];
    emailid = json['emailid'];
    userType = json['userType'];
    userImg = json['user_img'];
    createdate = json['createdate'];
    myRefercode = json['myRefercode'];
    dob = json['dob'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['personName'] = this.personName;
    data['contactno'] = this.contactno;
    data['Latitude'] = this.latitude;
    data['Longitude'] = this.longitude;
    data['status'] = this.status;
    data['alternet_no'] = this.alternetNo;
    data['emailid'] = this.emailid;
    data['userType'] = this.userType;
    data['user_img'] = this.userImg;
    data['createdate'] = this.createdate;
    data['myRefercode'] = this.myRefercode;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    return data;
  }
}

class Vehicledata {
  String? id;
  String? ntitle;
  String? image;
  String? defVeh;
  String? vStatus;

  Vehicledata({this.id, this.ntitle, this.image, this.defVeh, this.vStatus});

  Vehicledata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ntitle = json['ntitle'];
    image = json['image'];
    defVeh = json['def_veh'];
    vStatus = json['vStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ntitle'] = this.ntitle;
    data['image'] = this.image;
    data['def_veh'] = this.defVeh;
    data['vStatus'] = this.vStatus;
    return data;
  }
}