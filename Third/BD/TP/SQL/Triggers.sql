CREATE TRIGGER calculate_order_cost_trigger
AFTER INSERT ON Encomenda_Item
FOR EACH ROW
call calculate_order_cost(NEW.id_ecomenda);