import 'package:flutter/material.dart';

import '../models/service_provider_model.dart';
import '../services/service_api.dart';
import '../widgets/app_drawer.dart';
import '../widgets/service_card.dart';
import 'detail_screen.dart';

class DashboardScreen extends StatefulWidget {
  static const routeName = '/dashboard';

  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late Future<List<ServiceProviderModel>> _servicesFuture;
  bool _isGrid = false;
  String _search = '';

  @override
  void initState() {
    super.initState();
    _servicesFuture = ServiceApi().fetchServices();
  }

  List<ServiceProviderModel> _filterServices(List<ServiceProviderModel> services) {
    if (_search.trim().isEmpty) return services;
    final query = _search.toLowerCase();
    return services.where((service) {
      return service.name.toLowerCase().contains(query) || service.category.toLowerCase().contains(query);
    }).toList();
  }

  void _openDetails(ServiceProviderModel service) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DetailScreen(service: service)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('MyCityConnect'),
        actions: [
          IconButton(
            tooltip: _isGrid ? 'List View' : 'Grid View',
            icon: Icon(_isGrid ? Icons.view_list : Icons.grid_view),
            onPressed: () => setState(() => _isGrid = !_isGrid),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [Color(0xFF2563EB), Color(0xFF06B6D4)]),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Explore services near you', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                TextField(
                  onChanged: (value) => setState(() => _search = value),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Search salon, plumber, tuition...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<ServiceProviderModel>>(
              future: _servicesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text('Error: ${snapshot.error}', textAlign: TextAlign.center),
                    ),
                  );
                }

                final services = _filterServices(snapshot.data ?? []);
                if (services.isEmpty) {
                  return const Center(child: Text('No services found'));
                }

                if (_isGrid) {
                  return GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.78,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: services.length,
                    itemBuilder: (context, index) {
                      return ServiceCard(
                        service: services[index],
                        isGrid: true,
                        onTap: () => _openDetails(services[index]),
                      );
                    },
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.only(top: 8, bottom: 16),
                  itemCount: services.length,
                  itemBuilder: (context, index) {
                    return ServiceCard(
                      service: services[index],
                      isGrid: false,
                      onTap: () => _openDetails(services[index]),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
