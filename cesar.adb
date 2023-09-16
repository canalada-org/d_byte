-- Andres Soliño
-- 3-7-05


with D_Byte;
use D_Byte;
with Ada.Text_Io;
use Ada.Text_Io;
with Ada.Integer_Text_Io;
use Ada.Integer_Text_Io;

-- Un sencillo ejemplo para mostrar el uso de los bytes.
-- Leemos de un fichero, hacemos un desplazamiento mediante 
-- una contraseña (método César) y escribimos en otro fichero.

-- Evidentemente la seguridad es casi nula, basta ir probando las 
-- 255 posibilidades para sacaro. Y si cifras dos veces consecutivas
-- de forma que sumen 256 también se saca X-D


procedure Cesar is 
   C               : Character        := ' ';  
   B               : Byte;  
   Archivo_Entrada,  
   Archivo_Salida  : T_Binary_file;  
   Ruta_Entrada,  
   Ruta_Salida     : String (1 .. 32);  
   Password,  
   Long_Ent,  
   Long_Sal,  
   Aux             : Integer          := 0;  

begin
   
   while C/='c' and C/='d' loop
      Put_Line("Cifrar (c) o Descifrar (d)?");
      Get_Immediate (C);
      if C/='c' and C/='d' then
         New_Line;
         Put_Line("Error:Pulse la C o la D");
      end if;
   end loop;
   
   Put("Ha elegido: ");
   if C='c' then
      Put("Cifrar");
      New_Line(2);
   else
      Put("Descifrar");
      New_Line(2);
   end if;
   
   Put_Line("Introduzca el nombre del fichero de entrada (maximo 32 caracteres)");
   Get_Line(Ruta_Entrada,Long_Ent);
   Open(Archivo_Entrada,In_File,Ruta_Entrada(1..Long_Ent));


   Put_Line("Introduzca el nombre del fichero de salida (maximo 32 caracteres)");
   Put_Line("Ojo, sobreescribira el fichero sin preguntar!");
   Get_Line(Ruta_Salida,Long_Sal);
   Create(Archivo_Salida,Out_File,Ruta_Salida(1..Long_Sal));

   while Password<1 or Password>255 loop
      Put_Line("Elija un password (numero del 1 al 255)");
      Get(Password);
      if Password<1 or Password>255 then
         New_Line;
         Put_Line("Error: El valor no es correcto. Debe estar entre 1 y 255");
      end if;
   end loop;


   while not End_Of_File(Archivo_Entrada) loop
      Read(Archivo_Entrada,B);
      if C='c' then
         Aux:=(To_Integer(B)+Password) mod 256;
      else
         Aux:=(To_Integer(B)-Password) mod 256;
      end if;
      Write(Archivo_Salida,To_Byte(Aux));
   end loop;

   Close(Archivo_Entrada);
   Close(Archivo_Salida);

   Put_Line("Operacion realizada con exito");
   Put_Line("Presione cualquier tecla para finalizar");
   Get_Immediate(C);

exception
   when D_Byte.Name_Error=>
      Put_Line("Error: Nombre de archivo o ruta incorrectos");
   when D_Byte.Use_Error=>
      Put_Line("Error: El archivo ya esta abierto");
   when D_Byte.Data_Error =>
      Put_Line("Error: El dato introducido no es un numero entre 1 y 255 ");

end Cesar;