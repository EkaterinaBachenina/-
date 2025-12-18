CREATE TABLE products (
    product_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    quantity INT NOT NULL CHECK (quantity >= 0) -- Количество на складе
);

CREATE TABLE order_history (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    quantity_changed INT,
    notes VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO products (product_id, name, quantity) VALUES
(1, 'Ноутбук', 20),
(2, 'Смартфон', 50);

BEGIN;

UPDATE products 
SET quantity = quantity - 5 
WHERE name = 'Ноутбук';

INSERT INTO order_history (product_id, quantity_changed, notes) 
VALUES (1, -5, 'Продажа 5 ноутбуков');

COMMIT;


SELECT * FROM products WHERE name = 'Ноутбук';
SELECT * FROM order_history ORDER BY created_at DESC LIMIT 1;

BEGIN;

UPDATE products 
SET quantity = quantity - 100 
WHERE name = 'Смартфон';

-- До этой строки не дойдет из-за ошибки!

INSERT INTO order_history (product_id, quantity_changed, notes) 
VALUES (2, -100, 'Попытка продажи 100 смартфонов');

COMMIT; -- Не выполнится

SELECT * FROM products WHERE name = 'Смартфон'; -- quantity = 50 (не изменилось)
SELECT * FROM order_history WHERE product_id = 2 ORDER BY created_at DESC LIMIT 1; -- Нет новой записи

BEGIN;

UPDATE products 
SET quantity = quantity - 2 
WHERE name = 'Ноутбук';

-- Проверка платежа не прошла!
ROLLBACK;

-- Проверка
SELECT * FROM products WHERE name = 'Ноутбук';

BEGIN;
UPDATE products SET quantity = quantity - 10 WHERE product_id = 2;

SELECT * FROM products WHERE product_id = 2; 

COMMIT;

SELECT * FROM products WHERE product_id = 2; 