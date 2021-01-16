
 
 Testbench:
 
 Для каждой комбинации a0[31], a1[31]
 старших бит адреса
 
 01, 10
 
 Master_0 <-> Slave_0
 Master_1 <-> Slave_1
 
 Master_0 <-> Slave_1
 Master_1 <-> Slave_0 
 
 Запись -> Slave
 Чтение <- Slave
 Сравнение
 
 00, 11
 
 Master_0 <-> Slave_0
 Master_1 <-> Slave_0
 
 Master_0 <-> Slave_1
 Master_1 <-> Slave_1 
 
 Запись и чтение по 1 байту
 с чередованием мастера. 
 
 Запись -> Slave
 Чтение <- Slave
 Сравнение
  
 
 Временные диаграммы /TrailTask/ScreenShorts.