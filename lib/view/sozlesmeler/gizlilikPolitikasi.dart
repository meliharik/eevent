import 'package:event_app/view/viewModel/widthAndHeight.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GizlilikPolitikasiSayfa extends StatelessWidget {
  const GizlilikPolitikasiSayfa({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          'eevent',
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.04,
              color: Theme.of(context).primaryColor,
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w800),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).primaryColor.withOpacity(0.1),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                FontAwesomeIcons.chevronLeft,
                color: Theme.of(context).primaryColor,
                size: 20,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          boslukHeight(context, 0.01),
          Row(
            children: [
              boslukWidth(context, 0.03),
              Text(
                'Gizlilik Politikası',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w600,
                  fontSize: MediaQuery.of(context).size.height * 0.032,
                  color: Color(0xff252745),
                ),
              ),
              boslukWidth(context, 0.03),
            ],
          ),
          boslukHeight(context, 0.01),
          Row(
            children: [
              boslukWidth(context, 0.03),
              Expanded(
                child: Text(
                  '  - Güvenliğiniz bizim için önemli. Bu sebeple bizimle paylaşacağınız kişisel veriler hassasiyetle korunmaktadır.\n  - Biz, eevent veri sorumlusu olarak, bu gizlilik ve kişisel verilerin korunması politikası ile, hangi kişisel verilerinizin hangi amaçla işleneceği, işlenen verilerin kimlerle ve neden paylaşılabileceği, veri işleme yöntemimiz ve hukuki sebeplerimiz ile; işlenen verilerinize ilişkin haklarınızın neler olduğu hususunda sizleri aydınlatmayı amaçlıyoruz.',
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w400,
                    fontSize: MediaQuery.of(context).size.height * 0.02,
                    color: Color(0xff252745),
                  ),
                ),
              ),
              boslukWidth(context, 0.03),
            ],
          ),
          boslukHeight(context, 0.03),
          Row(
            children: [
              boslukWidth(context, 0.03),
              Expanded(
                child: Text(
                  'Toplanan Kişisel Verileriniz, Toplanma Yöntemi ve Hukuki Sebebi',
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w600,
                    fontSize: MediaQuery.of(context).size.height * 0.032,
                    color: Color(0xff252745),
                  ),
                ),
              ),
              boslukWidth(context, 0.03),
            ],
          ),
          boslukHeight(context, 0.01),
          Row(
            children: [
              boslukWidth(context, 0.03),
              Expanded(
                child: Text(
                  '  - IP adresiniz ve kullanıcı aracısı bilgileriniz, sadece analiz yapmak amacıyla ve çerezler (cookies) vb. teknolojiler vasıtasıyla, otomatik veya otomatik olmayan yöntemlerle ve bazen de analitik sağlayıcılar, reklam ağları, arama bilgi sağlayıcıları, teknoloji sağlayıcıları gibi üçüncü taraflardan elde edilerek, kaydedilerek, depolanarak ve güncellenerek, aramızdaki hizmet ve sözleşme ilişkisi çerçevesinde ve süresince, meşru menfaat işleme şartına dayanılarak işlenecektir.',
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w400,
                    fontSize: MediaQuery.of(context).size.height * 0.02,
                    color: Color(0xff252745),
                  ),
                ),
              ),
              boslukWidth(context, 0.03),
            ],
          ),
          boslukHeight(context, 0.03),
          Row(
            children: [
              boslukWidth(context, 0.03),
              Expanded(
                child: Text(
                  'Kişisel Verilerinizin İşlenme Amacı',
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w600,
                    fontSize: MediaQuery.of(context).size.height * 0.032,
                    color: Color(0xff252745),
                  ),
                ),
              ),
              boslukWidth(context, 0.03),
            ],
          ),
          boslukHeight(context, 0.01),
          Row(
            children: [
              boslukWidth(context, 0.03),
              Expanded(
                child: Text(
                  '  - Bizimle paylaştığınız kişisel verileriniz sadece analiz yapmak suretiyle; sunduğumuz hizmetlerin gerekliliklerini en iyi şekilde yerine getirebilmek, bu hizmetlere sizin tarafınızdan ulaşılabilmesini ve maksiumum düzeyde faydalanılabilmesini sağlamak, hizmetlerimizi, ihtiyaçlarınız doğrultusunda geliştirebilmek ve sizleri daha geniş kapsamlı hizmet sağlayıcıları ile yasal çerçeveler içerisinde buluşturabilmek ve kanundan doğan zorunlulukların (kişisel verilerin talep halinde adli ve idari makamlarla paylaşılması) yerine getirilebilmesi amacıyla, sözleşme ve hizmet süresince, amacına uygun ve ölçülü bir şekilde işlenecek ve güncellenecektir.',
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w400,
                    fontSize: MediaQuery.of(context).size.height * 0.02,
                    color: Color(0xff252745),
                  ),
                ),
              ),
              boslukWidth(context, 0.03),
            ],
          ),
          boslukHeight(context, 0.03),
          Row(
            children: [
              boslukWidth(context, 0.03),
              Expanded(
                child: Text(
                  'Kişisel Verileri İşlenen Kişi Olarak Haklarınız',
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w600,
                    fontSize: MediaQuery.of(context).size.height * 0.032,
                    color: Color(0xff252745),
                  ),
                ),
              ),
              boslukWidth(context, 0.03),
            ],
          ),
          boslukHeight(context, 0.01),
          Row(
            children: [
              boslukWidth(context, 0.03),
              Expanded(
                child: Text(
                  '  - KVKK madde 11 uyarınca herkes, veri sorumlusuna başvurarak aşağıdaki haklarını kullanabilir:\n\n a. Kişisel veri işlenip işlenmediğini öğrenme,\n b. Kişisel verileri işlenmişse buna ilişkin bilgi talep etme,\n c. Kişisel verilerin işlenme amacını ve bunların amacına uygun kullanılıp kullanılmadığını öğrenme,\n d. Yurt içinde veya yurt dışında kişisel verilerin aktarıldığı üçüncü kişileri bilme,\n e. Kişisel verilerin eksik veya yanlış işlenmiş olması hâlinde bunların düzeltilmesini isteme,\n f. Kişisel verilerin silinmesini veya yok edilmesini isteme,\n g. (e) ve (f) bentleri uyarınca yapılan işlemlerin, kişisel verilerin aktarıldığı üçüncü kişilere bildirilmesini isteme,\n h. İşlenen verilerin münhasıran otomatik sistemler vasıtasıyla analiz edilmesi suretiyle kişinin kendisi aleyhine bir sonucun ortaya çıkmasına itiraz etme,\n i. Kişisel verilerin kanuna aykırı olarak işlenmesi sebebiyle zarara uğraması hâlinde zararın giderilmesini talep etme, haklarına sahiptir.\n\n  - Yukarıda sayılan haklarınızı kullanmak üzere app.eevent@gmail.com üzerinden bizimle iletişime geçebilirsiniz.',
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w400,
                    fontSize: MediaQuery.of(context).size.height * 0.02,
                    color: Color(0xff252745),
                  ),
                ),
              ),
              boslukWidth(context, 0.03),
            ],
          ),
          boslukHeight(context, 0.03),
          Row(
            children: [
              boslukWidth(context, 0.03),
              Expanded(
                child: Text(
                  'İletişim',
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w600,
                    fontSize: MediaQuery.of(context).size.height * 0.032,
                    color: Color(0xff252745),
                  ),
                ),
              ),
              boslukWidth(context, 0.03),
            ],
          ),
          boslukHeight(context, 0.01),
          Row(
            children: [
              boslukWidth(context, 0.03),
              Expanded(
                child: Text(
                  '  - Sizlere hizmet sunabilmek amaçlı analizler yapabilmek için, sadece gerekli olan kişisel verilerinizin, işbu gizlilik ve kişisel verilerin işlenmesi politikası uyarınca işlenmesini, kabul edip etmemek hususunda tamamen özgürsünüz. Siteyi kullanmaya devam ettiğiniz takdirde kabul etmiş olduğunuz tarafımızca varsayılacak olup, daha ayrıntılı bilgi için bizimle app.eevent@gmail.com e-mail adresi üzerinden iletişime geçmekten lütfen çekinmeyiniz.',
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w400,
                    fontSize: MediaQuery.of(context).size.height * 0.02,
                    color: Color(0xff252745),
                  ),
                ),
              ),
              boslukWidth(context, 0.03),
            ],
          ),
          boslukHeight(context, 0.1),
        ],
      )),
    );
  }
}
