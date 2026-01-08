import 'package:flipcart/features/cart/model/cart_item_model.dart';
import 'package:flutter/material.dart';
import '../../core/utils/responsive_helper.dart';

class CartItemTile extends StatelessWidget {
  final CartItemModel item;
  final VoidCallback? onIncrease;
  final VoidCallback? onDecrease;
  final VoidCallback? onRemove;

  const CartItemTile({
    super.key,
    required this.item,
    this.onIncrease,
    this.onDecrease,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final r = AppResponsive(context);

    return Card(
      margin: EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(r.value(mobile: 12, tablet: 16)),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                item.image,
                width: r.value(mobile: 60, tablet: 80),
                height: r.value(mobile: 60, tablet: 80),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: r.value(mobile: 12, tablet: 16)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.name,
                      style: TextStyle(
                          fontSize: r.font(16), fontWeight: FontWeight.w600)),
                  SizedBox(height: r.value(mobile: 4, tablet: 6)),
                  Text('₹${item.price}',
                      style: TextStyle(
                        fontSize: r.font(14),
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      )),
                  SizedBox(height: r.value(mobile: 8, tablet: 12)),
                  Row(
                    children: [
                      _QtyButton(icon: Icons.remove, onTap: onDecrease),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text('${item.quantity}',
                            style: TextStyle(
                                fontSize: r.font(16),
                                fontWeight: FontWeight.bold)),
                      ),
                      _QtyButton(icon: Icons.add, onTap: onIncrease),
                    ],
                  )
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
              onPressed: onRemove,
            ),
          ],
        ),
      ),
    );
  }
}

class _QtyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  const _QtyButton({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(6)),
        child: Icon(icon, size: 18),
      ),
    );
  }
}
