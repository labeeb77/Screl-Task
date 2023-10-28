
import 'package:flutter/material.dart';
import 'package:screl_test/constants/colors.dart';
import 'package:screl_test/model/model.dart';
import 'package:screl_test/service/api_service.dart';
import 'package:screl_test/view/widget/custom_button.dart';

class DetailsPage extends StatelessWidget {
  final UserModel model;

  const DetailsPage({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PrimaryColor,
        title: const Text(
          'User Details',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CustomButton(
              width: 100,
              height: 40,
              borderRadius: 14,
              color: Colors.white,
              onPressed: () {
                ApiService()
                    .openMaps(model.address.geo.lat, model.address.geo.lng);
              },
              child: Row(
                children: [
                  Icon(Icons.location_on, color: PrimaryColor),
                  const SizedBox(width: 8),
                  const Text('Location'),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildUserCard(),
                _buildLocationCard(),
                _buildCompanyCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserCard() {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      child: ListTile(
        title: const Text('User Information',
            style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetail('Name', model.name),
            _buildDetail('Username', model.username),
            _buildDetail('Email', model.email),
            _buildDetail('Phone', model.phone),
            _buildDetail('Website', model.website),
          ],
        ),
      ),
    );
  }

  Widget _buildDetail(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(value),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildLocationCard() {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      child: ListTile(
        title: const Text('Address and Geo Location',
            style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetail('Address',
                '${model.address.street}, ${model.address.suite}, ${model.address.city}, ${model.address.zipcode}'),
            _buildDetail('Geo Location',
                'Lat: ${model.address.geo.lat}, Lng: ${model.address.geo.lng}'),
          ],
        ),
      ),
    );
  }

  Widget _buildCompanyCard() {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      child: ListTile(
        title: const Text('Company Information',
            style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetail('Company Name', model.company.name),
            _buildDetail('Catch Phrase', model.company.catchPhrase),
            _buildDetail('Business', model.company.bs),
          ],
        ),
      ),
    );
  }
}
