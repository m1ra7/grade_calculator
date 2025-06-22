import 'package:flutter/material.dart';
import 'package:grade_calculator/constants/app_constants.dart';
import 'package:grade_calculator/helper/data_helper.dart';
import 'package:grade_calculator/model/ders.dart';
import 'package:grade_calculator/widgets/ortalama_goster.dart';

class OrtalamaHesapla extends StatefulWidget {
  const OrtalamaHesapla({super.key});

  @override
  State<OrtalamaHesapla> createState() => _OrtalamaHesaplaState();
}

class _OrtalamaHesaplaState extends State<OrtalamaHesapla> {
  List<Ders> tumDersler = [];

  double secilen = 1;
  double secilenKredi = 1;
  String girilenDersAdi = 'Ders Adı Girilmemiş';
  double krediDegeri = 1;
  double notDegeri = 4;

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: Text(
            'Ortalama Hesapla',
            style: Sabitler.textStyle(
              24,
              FontWeight.w900,
              Sabitler.anaRenk(context),
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 2, child: myForm()),
              Expanded(
                child: OrtalamaGoster(
                  dersSayisi: tumDersler.length,
                  ortalama: ortalamaHesapla(),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Dersler:",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Sabitler.anaRenk(context),
                    )),
          ),
          Expanded(
            child: tumDersler.isNotEmpty
                ? ListView.builder(
                    itemBuilder: (context, index) => Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.startToEnd,
                      onDismissed: (a) {
                        setState(() {
                          tumDersler.removeAt(index);
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: Card(
                          child: ListTile(
                            title: Text(tumDersler[index].ad),
                            leading: CircleAvatar(
                              backgroundColor: Sabitler.anaRenk(context),
                              child: Text(
                                (tumDersler[index].krediDegeri *
                                        tumDersler[index].harfDegeri)
                                    .toStringAsFixed(0),
                                style: TextStyle(
                                    color: Sabitler.circleAvatarText(context)),
                              ),
                            ),
                            subtitle: Text(
                                '${tumDersler[index].krediDegeri} Kredi, Not Değeri ${tumDersler[index].harfDegeri}'),
                          ),
                        ),
                      ),
                    ),
                    itemCount: tumDersler.length,
                  )
                : Container(
                    margin: const EdgeInsets.all(24),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text('Lütfen ders ekleyiniz',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color: Sabitler.anaRenk(context),
                                  )),
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Form myForm() {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
            child: _buildTextFormField(),
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  child: _buildHarfler(),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  child: _buildKrediler(),
                ),
              ),
              IconButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    var eklenecekDers =
                        Ders(girilenDersAdi, secilen, secilenKredi);
                    tumDersler.insert(0, eklenecekDers);
                    ortalamaHesapla();
                    setState(() {});
                  }
                },
                icon: Icon(
                  Icons.add,
                  color: Sabitler.anaRenk(context),
                  size: 30,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  TextFormField _buildTextFormField() {
    return TextFormField(
      onSaved: (deger) => girilenDersAdi = deger!,
      validator: (s) => s!.isEmpty ? 'Lütfen ders adını giriniz' : null,
      decoration: InputDecoration(
        hintText: 'Ders adını giriniz',
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Sabitler.anaRenk(context),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Sabitler.anaRenk(context),
          ),
        ),
      ),
    );
  }

  Widget _buildHarfler() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Sabitler.anaRenk(context), width: 1),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<double>(
              isExpanded: true,
              iconEnabledColor: Sabitler.anaRenk(context),
              value: secilen,
              items: DataHelper.tumDersHarfleri(),
              onChanged: (value) {
                setState(() {
                  secilen = value!;
                });
              },
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(2.0),
          child: Text("Ders Harfi"),
        )
      ],
    );
  }

  Widget _buildKrediler() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Sabitler.anaRenk(context), width: 1),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<double>(
              isExpanded: true,
              iconEnabledColor: Sabitler.anaRenk(context),
              value: secilenKredi,
              items: DataHelper.tumKrediler(),
              onChanged: (value) {
                setState(() {
                  secilenKredi = value!;
                });
              },
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(2.0),
          child: Text("Ders Kredisi"),
        )
      ],
    );
  }

  double ortalamaHesapla() {
    double toplamNot = 0;
    double toplamKredi = 0;
    for (var element in tumDersler) {
      toplamNot = toplamNot + (element.krediDegeri * element.harfDegeri);
      toplamKredi = toplamKredi + element.krediDegeri;
    }
    return toplamNot / toplamKredi;
  }
}
