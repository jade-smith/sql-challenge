-- employees.csv
CREATE TABLE Employees (
  emp_no INT PRIMARY KEY ,
  birth_date DATE,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  gender CHAR(1),
  hire_date DATE
);

-- departments.csv
CEATE TABLES Departments (
  dept_no CHAR(4) PRIMARY KEY,
  dept_name VARCHAR(100)
);

-- dept_manager.csv
CREATE TABLE Dept_Manager(
  emp_no INT,
  dept_no CHAR(4),
  from_date DATE,
  to_date DATE,
  PRIMARY KEY (emp_no, dept_no),
  FOREIGN KEY (emp_no) REFERENCES Employees(emp_no),
  FOREIGN KEY (dept_no) REFERENCES Departments(dept_no)
);

-- dept_emp.csv
CREATE TABLE Dept_Emp (
    emp_no INT,
    dept_no CHAR(4),
    from_date DATE,
    to_date DATE,
    PRIMARY KEY (emp_no, dept_no),
    FOREIGN KEY (emp_no) REFERENCES Employees(emp_no),
    FOREIGN KEY (dept_no) REFERENCES Departments(dept_no)
);

-- salaries.csv
CREATE TABLE Salaries (
    emp_no INT,
    salary INT,
    from_date DATE,
    to_date DATE,
    PRIMARY KEY (emp_no, from_date),
    FOREIGN KEY (emp_no) REFERENCES Employees(emp_no)
);

-- titles.csv
CREATE TABLE Titles (
    emp_no INT,
    title VARCHAR(50),
    from_date DATE,
    to_date DATE,
    PRIMARY KEY (emp_no, from_date),
    FOREIGN KEY (emp_no) REFERENCES Employees(emp_no)
);

-- import CSV into SQL tables
COPY Employees FROM 'EmployeeSQL/Starter_Code/data/employees.csv' DELIMITER ',' CSV HEADER;
COPY Departments FROM 'EmployeeSQL/Starter_Code/data/departments.csv' DELIMITER ',' CSV HEADER;
COPY Dept_Manager FROM 'EmployeeSQL/Starter_Code/data/dept_manager.csv' DELIMITER ',' CSV HEADER;
COPY Dept_Emp FROM 'EmployeeSQL/Starter_Code/data/dept_emp.csv' DELIMITER ',' CSV HEADER;
COPY Salaries FROM 'EmployeeSQL/Starter_Code/data/salaries.csv' DELIMITER ',' CSV HEADER;
COPY Titles FROM 'EmployeeSQL/Starter_Code/data/titles.csv' DELIMITER ',' CSV HEADER;

-- list employee number, first name, last name, gender, and salary
SELECT Employees.emp_no, Employees.last_name, Employees.first_name, Employees.gender, Salaries.salary
FROM Employees
INNER JOIN Salaries ON Employees.emp_no = Salaries.emp_no;

-- list of first name, last name, and hire date of employees hired in 1986
SELECT first_name, last_name, hire_date
FROM Employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';

-- list of managers of each department along with their department number, department name, employee number, first name, and last name
SELECT d.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name
FROM Departments d
INNER JOIN Dept_Manager dm ON d.dept_no = dm.dept_no
INNER JOIN Employees e ON dm.emp_no = e.emp_no;

-- list department number for each employee along with employee number, first name, last name, and department name\
SELECT de.emp_no, e.last_name, e.first_name, de.dept_no, d.dept_name
FROM Dept_Emp de
INNER JOIN Employees e ON de.emp_no = e.emp_no
INNER JOIN Departments d ON de.dept_no = d.dept_no;

-- list first name, last name, and gender of each employee whose first name is Hercules and last name begins with B
SELECT first_name, last_name, gender
FROM Employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

-- list each employee in the Sales and Development department along with employee number, first name, last name, and department name
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM Employees e
INNER JOIN Dept_Emp de ON e.emp_no = de.emp_no
INNER JOIN Departments d ON de.dept_no = d.dept_no
WHERE d.dept_name IN ('Sales', 'Development');

-- list frequency counts, in decending order, of all employees' last names
SELECT last_name, COUNT(*) AS frequency
FROM Employees
GROUP BY last_name
ORDER BY frequency DESC;
