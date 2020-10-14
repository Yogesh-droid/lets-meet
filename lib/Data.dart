class Data{
  String img;
  String name;
  String address;
  int age;
  Data(this.img, this.name, this.address,this.age);
  Data.getInstance();

  String get getName{
    return name;
  }
  String  get getImage{
    return img;
  }
  String  get  getAddress{
    return address;
  }
  int  get  getAge{
    return age;
  }
}