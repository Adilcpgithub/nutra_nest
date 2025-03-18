import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutra_nest/core/theme/app_theme.dart';
import 'package:nutra_nest/page/bottom_navigation/order/data/models/order_model.dart';
import 'package:nutra_nest/page/bottom_navigation/order/presentation/bloc/user_order_bloc/user_order_bloc.dart';
import 'package:nutra_nest/utity/colors.dart';
import 'package:nutra_nest/widgets/icons_widget.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  void initState() {
    context.read<UserOrderBloc>().add(const FetchUserOrders());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 10),
              buildHeader(),
              const SizedBox(height: 20),
              Expanded(
                child: BlocBuilder<UserOrderBloc, UserOrderState>(
                  builder: (context, state) {
                    if (state is UserOrderLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: CustomColors.green,
                        ),
                      );
                    } else if (state is UserOrderSuccess) {
                      return state.orders.isEmpty
                          ? _buildEmptyState()
                          : _buildOrdersList(state.orders);
                    } else if (state is UserOrderError) {
                      return Center(
                        child: Text(
                          state.message,
                          style: TextStyle(
                            color: customTextTheme(context),
                            fontSize: 16,
                          ),
                        ),
                      );
                    }
                    return _buildEmptyState();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_bag_outlined,
            size: 80,
            // ignore: deprecated_member_use
            color: customTextTheme(context).withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            "No Orders Yet",
            style: TextStyle(
              color: customTextTheme(context),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Start shopping to see your orders here",
            style: TextStyle(
              // ignore: deprecated_member_use
              color: customTextTheme(context).withOpacity(0.7),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersList(List<OrderModel> orders) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return _buildOrderCard(order);
      },
    );
  }

  Widget _buildOrderCard(OrderModel order) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Order #${order.orderId.substring(6, 14)}",
                      style: TextStyle(
                        color: customTextTheme(context),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatDate(order.createdAt.toDate()),
                      style: TextStyle(
                        // ignore: deprecated_member_use
                        color: customTextTheme(context).withOpacity(0.7),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                _buildStatusBadge(order.status),
              ],
            ),
            const Divider(height: 24),
            // Order Items
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: order.items.length,
              itemBuilder: (context, index) {
                final product = order.items[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          product.imageUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            width: 50,
                            height: 50,
                            color: Colors.grey[200],
                            child: const Icon(Icons.error, size: 20),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: TextStyle(
                                color: customTextTheme(context),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "Qty: ${product.productCount}",
                              style: TextStyle(
                                color:
                                    // ignore: deprecated_member_use
                                    customTextTheme(context).withOpacity(0.7),
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "₹${product.price}",
                        style: const TextStyle(
                          color: CustomColors.green,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Amount",
                  style: TextStyle(
                    color: customTextTheme(context),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "₹${order.totalPrice}",
                  style: const TextStyle(
                    color: CustomColors.green,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

//! fetching order status
  Widget _buildStatusBadge(String status) {
    Color statusColor;
    switch (status.toLowerCase()) {
      case 'delivered':
        statusColor = Colors.green;
        break;
      case 'processing':
        statusColor = Colors.orange;
        break;
      case 'cancelled':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.blue;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: statusColor),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: statusColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  Widget buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomIcon(
            onTap: () {
              Navigator.pop(context);
            },
            icon: Icons.arrow_back,
            iconSize: 26),
        Expanded(
          child: Text(
            'Order History',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 19,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).textTheme.bodySmall!.color,
            ),
          ),
        ),
        //   CustomIcon(onTap: () {}, icon: Icons.search, iconSize: 29)
      ],
    );
  }
}
