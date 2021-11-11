all: lab1.bin
	cp img/disk.img .			#копируем сохраненный образ диска в текущий каталог
	dd if=lab1.bin of=disk.img  bs=`stat lab1.bin -c %s` count=1 conv=notrunc #копирование в начало диска
		
lab1.o: lab1.S
	cpp -o lab1.s lab1.S					#макрорасширение	
	as -o lab1.o lab1.s						#трансляция

lab1.bin: lab1.o
	ld -N -e _start -Ttext 0x7C00 -o lab1.elf lab1.o		#компоновка с адреса 0x7C00
	objcopy -S -O binary lab1.elf lab1.bin					#вырезаем все, кроме бинарного кода

clean:
	rm *.o *.elf *.bin *.s *.img			#очистка каталога от объектных файлов

