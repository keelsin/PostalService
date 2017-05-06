CREATE OR REPLACE PROCEDURE addMail()
AS
END;



CREATE OR REPLACE PROCEDURE addCustomer(name IN VARCHAR2,phone_number IN VARCHAR2,
      premium IN CHAR, postal_code IN VARCHAR2, street IN VARCHAR2,
      city IN VARCHAR2, country IN VARCHAR2)
AS
  address_id VARCHAR2(20);
BEGIN
  INSERT INTO postal_code VALUES(postal_code,NULL);
  INSERT INTO address VALUES(address_id_seq.NEXTVAL,postal_code,street,city,country);
  INSERT INTO customer VALUES (customer_id_seq.NEXTVAL,address_id_seq.CURRVAL,phone_number,name,premium);
END;

DROP procedure addCustomer;
/*    TEST    WORKS!!
  EXECUTE addCustomer('Keylen',NULL,0,'K3R 5l3', 'leclerc','montreal','Can');
*/



CREATE OR REPLACE FUNCTION shippingCost()
RETURN NUMBER
/*If the customer is a premium customer then the postage is free*/
AS
END;



CREATE OR REPLACE PROCEDURE becomePremium()
AS
END;



CREATE OR REPLACE PROCEDURE prepareMail()
AS 
END;



CREATE OR REPLACE PROCEDURE markAS()
AS END;



CREATE OR REPLACE PROCEDURE viewMail()
AS
END;



CREATE OR REPLACE PROCEDURE modifyPass()
AS
END;



CREATE OR REPLACE TRIGGER automaticPostageInsert
BEGIN 
END;



CREATE OR REPLACE TRIGGER createAddressWhenMailReceived
BEGIN 
END;