class Validate{
  Map data;
  Validate(this.data);

  checkKeyExists({String key ="", dynamic initialize}){
    return (data.containsKey(key) && data[key]!=null)?data[key]:initialize;
  }
}