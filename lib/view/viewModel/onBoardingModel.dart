class OnbordingContent {
  String? image;
  String? title;
  String? discription;

  OnbordingContent({this.image, this.title, this.discription});
}

List<OnbordingContent> contents = [
  OnbordingContent(
      title: 'Becerilerini Geliştir',
      image: 'assets/onBoarding/onBoard1.png',
      discription: 'Her geçen gün yeni bir bilgi öğren!'),
  OnbordingContent(
      title: 'Yeni İnsanlar Tanı',
      image: 'assets/onBoarding/onBoard2.png',
      discription: 'Etkinlikler sayesinde farklı sektörlerden insanlar tanı!'),
  OnbordingContent(
      title: 'Bir Adım Önde Ol',
      image: 'assets/onBoarding/onBoard3.png',
      discription: 'Meslektaşlarının arasından kolayca sıyrıl!'),
  OnbordingContent(
      title: 'Çağa Ayak Uydur',
      image: 'assets/onBoarding/onBoard4.png',
      discription: 'Gün geçtikçe ilerleyen teknolojide yerini al!'),
];
