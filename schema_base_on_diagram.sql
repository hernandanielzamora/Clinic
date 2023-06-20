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



/* INDEXES */

CREATE INDEX history_patient_index ON medical_histories(patient_id);
CREATE INDEX invoices_history_index ON invoices(medical_history_id);
