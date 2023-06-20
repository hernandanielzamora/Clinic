/* TABLES */

CREATE TABLE patients (
  id INT PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(100) NOT NULL,
  date_of_birth DATE NOT NULL
);

CREATE TABLE medical_histories (
  id INT PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY,
  admitted_at TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
  patient_id INT NOT NULL,
  status VARCHAR(120) NOT NULL,
  CONSTRAINT fk_patient_id FOREIGN KEY (patient_id) REFERENCES patients(id),
);

CREATE TABLE invoices (
  id INT PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY,
  total_amount DECIMAL (8, 2),
  generated_at TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
  payed_at TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
  medical_history_id INT,
  CONSTRAINT fk_medHistory_id FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id)
);

CREATE TABLE invoice_items (
  id INT PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY,
  unit_price DECIMAL (8, 2),
  quantity INT NOT NULL,
  total_price DECIMAL(8, 2),
  invoice_id INT,
  treatment_id INT,
  CONSTRAINT fk_invoice_id FOREIGN KEY (invoice_id) REFERENCES invoices(id),
  CONSTRAINT fk_treatment_id FOREIGN KEY (treatment_id) REFERENCES treatments(id)
);

CREATE TABLE treatments (
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  type VARCHAR(100) NOT NULL,
  name VARCHAR(100) NOT NULL
);

CREATE TABLE medical_treatment_table (
  medical_histories_id INT references medical_histories(id), 
  treatments_id INT references treatments(id)
);

/* INDEXES */

CREATE INDEX history_patient_index ON medical_histories(patient_id);
CREATE INDEX invoices_history_index ON invoices(medical_history_id);
CREATE INDEX invoices_items_index ON invoice_items(invoice_id);
CREATE INDEX invoicetreatment_index ON invoice_items(treatment_id);
