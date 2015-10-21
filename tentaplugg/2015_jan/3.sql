CREATE FUNCTION fixOrder() RETURNS TRIGGER AS $pname$
BEGIN
    UPDATE Stock SET amount=amount-NEW.amount WHERE product=NEW.product AND location = NEW.location;
    
    UPDATE Orders
    SET items=items+1, total_weight=total_weight + NEW.amount*(SELECT weight FROM Product WHERE Product.id=NEW.product),
        total_item_cost = total_item_cost + NEW.amount*(SELECT price FROM Product WHERE product.id=New.product)
    WHERE id=NEW.order;
    
    
    RETURN NEW;
END;
$pname$ LANGUAGE plpgsql;
CREATE TRIGGER addItem AFTER
INSERT ON Order item FOR EACH ROW
EXECUTE PROCEDURE fixOrder();

--3 d) Modify fixOrder() to also add to the total_item_cost the new product price times the Order_item amount.
