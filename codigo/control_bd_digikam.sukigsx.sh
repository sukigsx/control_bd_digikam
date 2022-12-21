#!/bin/bash

#colores
rojo="\e[0;31m\033[1m" #rojo
verde="\e[;32m\033[1m"
azul="\e[0;34m\033[1m"
amarillo="\e[0;33m\033[1m"
rosa="\e[0;35m\033[1m"
turquesa="\e[0;36m\033[1m"
borra_colores="\033[0m\e[0m" #borra colores

##funcion verificacion de conexion y tambien de fostware necesario
function comprobar()
{
clear
echo -e ""
echo -e "${verde} Verificando software necesario.${borra_colores}"
echo -e ""
## Vericica conexion a internet
if ping -c1 google.com &>/dev/null;
    then
        echo -e " [${verde}ok${borra_colores}] Conexion a internet."
        conexion="si" #sabemos si tenemos conexion a internet o no
    else
        echo -e " [${rojo}XX${borra_colores}] Conexion a internet."
        conexion="no" #sabemos si tenemos conexion a internet o no
fi

for paquete in git wmctrl figlet digikam locate #ponemos el fostware a instalar separado por espacios
do
    which $paquete 2>/dev/null 1>/dev/null 0>/dev/null #comprueba si esta el programa llamado programa
    sino=$? #recojemos el 0 o 1 del resultado de which
    contador="1" #ponemos la variable contador a 1
    while [ $sino -gt 0 ] #entra en el bicle si variable programa es 0, no lo ha encontrado which
    do
        if [ $contador = "4" ] || [ $conexion = "no" ] #si el contador es 4 entre en then y sino en else
        then #si entra en then es porque el contador es igual a 4 y no ha podido instalar o no hay conexion a internet
            echo ""
            echo -e " ${amarillo}NO se ha podido instalar ($paquete).${borra_colores}"
            echo -e " ${amarillo}Intentelo usted con la orden:${borra_colores}"
            echo -e " ${rojo}-- sudo apt install $paquete --${borra_colores}"
            echo -e ""
            echo -e " ${rojo}No se puede ejecutar el script.${borra_colores}"
            echo ""
            exit
        else #intenta instalar
            echo " Instalando $paquete. Intento $contador/3."
            sudo apt install $paquete -y 2>/dev/null 1>/dev/null 0>/dev/null
            let "contador=contador+1" #incrementa la variable contador en 1
            which $paquete 2>/dev/null 1>/dev/null 0>/dev/null #comprueba si esta el programa en tu sistema
            sino=$? ##recojemos el 0 o 1 del resultado de which
        fi
done
    echo -e " [${verde}ok${borra_colores}] $paquete."

done
if [ $conexion = "no" ]
then
    echo -e ""
    echo -e "${rojo} Este script no se puede ejecutar correctamente."
    echo -e " Si NO dispone de conexion a internet.${borra_colores}"
    echo -e ""
    exit
else
    echo -e ""
    echo -e "${verde} Continuamos...${borra_colores}"
    sleep 2
fi

#comprueba actualiczacion del script
if [ -e /usr/bin/control_bd_digikam.sukigsx.sh ] #comprueba si se ha instalado el script con el deb, comprobando el fichero /usr/bin/inicio.sukigsx.sh
then
    ruta="/usr/bin"
    mkdir /tmp/com_update 2>/dev/null 1>/dev/null 0>/dev/null
    git clone https://github.com/sukigsx/control_bd_digikam.git /tmp/com_update 2>/dev/null 1>/dev/null 0>/dev/null
    diff /tmp/com_update/codigo/control_bd_digikam.sukigsx.sh $ruta/control_bd_digikam.sukigsx.sh 2>/dev/null 1>/dev/null 0>/dev/null
    if [ $? = "0" ] 2>/dev/null 1>/dev/null 0>/dev/null
    then
        echo -e " [${verde}ok${borra_colores}] script, esta actualizado."
    else
        echo -e " [${rojo}X${borra_colores}] ${amarillo}script NO actualizado, puedes actualizarlo en la opcion ( 0 ).${borra_colores}";sleep 2
    fi
    sudo rm -r /tmp/com_update 2>/dev/null 1>/dev/null 0>/dev/null
else
    ruta=$(pwd)
    mkdir /tmp/com_update 2>/dev/null 1>/dev/null 0>/dev/null
    git clone https://github.com/sukigsx/control_bd_digikam.git /tmp/com_update 2>/dev/null 1>/dev/null 0>/dev/null
    diff /tmp/com_update/codigo/control_bd_digikam.sukigsx.sh $ruta/control_bd_digikam.sukigsx.sh 2>/dev/null 1>/dev/null 0>/dev/null
    if [ $? = "0" ] 2>/dev/null 1>/dev/null 0>/dev/null
    then
        echo -e " [${verde}ok${borra_colores}] script, esta actualizado."
    else
        echo -e " [${rojo}XX${borra_colores}] ${amarillo}script NO actualizado, puedes actualizarlo en la opcion ( 0 ).${borra_colores}";sleep 3
    fi
    sudo rm -r /tmp/com_update 2>/dev/null 1>/dev/null 0>/dev/null
fi
echo ""
echo -e " ${verde}Todo el software correcto.${borra_colores}"
sleep 3
}

#toma el control al pulsar control + c
trap ctrl_c INT
function ctrl_c()
{
clear
figlet -c Gracias por
figlet -c utilizar mi
figlet -c script
wmctrl -r :ACTIVE: -b remove,maximized_vert,maximized_horz
exit
}

comprobar
clear
wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
echo -e "${rosa}"; figlet -c sukigsx; echo -e "${borra_colores}"

function configuracion_script()
{
if [ -f /home/$(whoami)/.config/control_bd_digikam.sukigsx ]
then
    echo ""
else
    echo -e ""
    echo -e "${azul} Datos de configuracion del script.${borra_colores}"
    echo -e ""
    read -p " Direccion absoluta de la base de datos del servidor -->> " baseservidor
    read -p " Direccion absoluta de la base de datos en local -->> " baselocal
    echo -e ""
    echo -e " Servidor =${verde} $baseservidor${borra_colores}"
    echo -e " Local    =${verde} $baselocal${borra_colores}"
    echo -e ""
    read -p " ¿Son correctos los datos? (s/n) -->> " sn
    echo ""
    if [[ $sn = "s" ]] || [[ $sn = "S" ]]
    then
        echo -e "${amarillo} Creando fichero de configuracion en ${borra_colores}/home/$(whoami)/.config"
        echo -e "${amarillo} con el nombre = ${borra_colores}control_bd_digikam.sukigsx"
        echo " baseservidor=$baseservidor" >> /home/$(whoami)/.config/control_bd_digikam.sukigsx
        echo " baselocal=$baselocal" >> /home/$(whoami)/.config/control_bd_digikam.sukigsx
        sleep 2
    else
        clear
        echo -e "${rosa} Necesario configurar el script${borra_colores}"
        sleep 3
        configuracion_script
    fi
fi
}


#se comprueba que el script este configurado
if [ -f /home/$(whoami)/.config/control_bd_digikam.sukigsx ]
then
    source /home/$(whoami)/.config/control_bd_digikam.sukigsx
else
    configuracion_script
fi

while :
do
clear
echo -e ""
echo -e "${verde} Seleciona una opcion del menu para tu ejecucion de DIGIKAM.${borra_colores}"
echo -e ""
echo -e "  0- ${verde}Actualizar el script.${borra_colores}"
echo -e ""
echo -e "  1- ${verde}Ejecutar Digikam.${borra_colores}"
echo -e ""
echo -e "  2- ${amarillo}Copiar la Base de datos del servidor a local.${borra_colores}"
echo -e "   ${rojo}  Esto BORRARA la base de datos de tu ordenador.${borra_colores}"
echo -e ""
echo -e "  3- ${amarillo}Copiar la base de datos de local al servidor.${borra_colores}"
echo -e "   ${rojo}  Esto BORRARA la base de datos del SERVIDOR.${borra_colores}"
echo -e ""
echo -e "  4- ${verde}Ver fichero de configuracion del script.${borra_colores}"
echo -e "  5- ${amarillo}Resetear la configuracion del script.${borra_colores}"
echo -e ""
echo -e "  6- ${rojo}Borrar la configuracion de digikam (base de datos y ficheros de configuracion).${borra_colores}"
echo -e ""
echo -e " 90- ${verde}Ayuda.${borra_colores}"
echo -e ""
echo -e " 99- ${turquesa}Salir (Ctrl-c).${borra_colores}"
echo -e ""
read -p " Escoje una opcion -->> " opcion
    case $opcion in

        0)  #actualizar el script
            if [ -e /usr/bin/montar_unidades.sukigsx.sh ] #comprueba si se ha instalado el script con el deb, comprobando el fichero /usr/bin/inicio.sukigsx.sh
            then
                ruta="/usr/bin"
                cd /tmp
                mkdir temporal_update
                git clone https://github.com/sukigsx/control_bd_digikam.git /tmp/temporal_update
                cd /tmp/temporal_update/codigo/
                sudo chmod +x $ruta/*.sukigsx.sh
                sudo cp -r /tmp/temporal_update/codigo/* $ruta
                sudo rm -r /tmp/temporal_update
                clear
                echo "";
                echo -e "${verde} Script actualizado. Tienes que reiniciar el script para ver los cambios.${borra_colores}";
                echo "";
                read -p " Pulsa una tecla para continuar." pause
                ctrl_c;
            else
                ruta=$(pwd)
                cd /tmp
                mkdir temporal_update
                git clone https://github.com/sukigsx/control_bd_digikam.git /tmp/temporal_update
                cd /tmp/temporal_update/codigo/
                sudo chmod +x $ruta/*.sukigsx.sh
                sudo cp -r /tmp/temporal_update/codigo/* $ruta
                sudo rm -r /tmp/temporal_update
                clear
                echo "";
                echo -e "${verde} Script actualizado. Tienes que reiniciar el script para ver los cambios.${borra_colores}";
                echo "";
                read -p " Pulsa una tecla para continuar." pause
                ctrl_c;
            fi;;

        1)  #ejecutar el digikam
            wmctrl -r :ACTIVE: -b remove,maximized_vert,maximized_horz
            digikam -qwindowtitle %c
            wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz;;

        2)  #copiar la base de datos del servidor a local
            #cd $baselocal
            #rm -r *
            if [ -d $baseservidor ]
            then
                if diff $baseservidor $baselocal  0>/dev/null 1>/dev/null 2>/dev/null
                then
                    echo -e ""
                    echo -e "${verde} Base de datos de tu servidor sincronizada correctamente en local.${borra_colores}"
                else
                    echo -e ""
                    echo -e "${amarillo} Sincronizando base de datos.${borra_colores}"
                    echo -e ""
                    rsync -r --delete --progress $baseservidor $baselocal
                    if diff $baseservidor $baselocal  0>/dev/null 1>/dev/null 2>/dev/null
                    then
                        echo -e ""
                        echo -e "${verde} Base de datos de tu servidor sincronizada correctamente en local.${borra_colores}"
                    else
                        echo -e ""
                        echo -e "${rojo} La sincronizacion de la base de datos NO se ha podido sincronizar correctamente.${borra_colores}"
                    fi
                fi
            else
                echo -e ""
                echo -e "${amarillo} No se encuentra el servidor o la carpeta montada.${borra_colores}"
            fi
            echo -e ""
            read -p " Pulsa una tecla para continuar.";;

        3)  #copiar la base de datos de local al servidor
            #cd $baselocal
            #rm -r *
            if [ -d $baseservidor ]
            then
                if diff $baseservidor $baselocal  0>/dev/null 1>/dev/null 2>/dev/null
                then
                    echo -e ""
                    echo -e "${verde} Base de datos local sincronizada correctamente en el servidor.${borra_colores}"
                else
                    echo -e ""
                    echo -e "${amarillo} Sincronizando base de datos.${borra_colores}"
                    echo -e ""
                    rsync -r --delete --progress $baselocal $baseservidor
                    if diff $baseservidor $baselocal  0>/dev/null 1>/dev/null 2>/dev/null
                    then
                        echo -e ""
                        echo -e "${verde} Base de datos local sincronizada correctamente en el servidor.${borra_colores}"
                    else
                        echo -e ""
                        echo -e "${rojo} La sincronizacion de la base de datos NO se ha podido sincronizar correctamente.${borra_colores}"
                    fi
                fi
            else
                echo -e ""
                echo -e "${amarillo} No se encuentra el servidor o la carpeta montada.${borra_colores}"
            fi
            echo -e ""
            read -p " Pulsa una tecla para continuar.";;

        4)  #ver la configuracion.
            clear
            echo -e ""
            echo -e "${verde} Listado del fichero de configuracion.${borra_colores}"
            echo -e ""
            cat /home/$(whoami)/.config/control_bd_digikam.sukigsx
            echo -e ""
            echo -e "${verde} Pulsa una tecla para continuar.${borra_colores}"
            read pause;;

        5)  #resetear la configuracion
            clear
            echo -e ""
            echo -e "${verde} Has seleccionado borrar el fichero de configuracion."
            echo -e " con el siguiente contenido:${borra_colores}"
            echo -e ""
            cat /home/$(whoami)/.config/control_bd_digikam.sukigsx
            echo -e ""
            read -p " ¿Seguro que quieres eliminarlo? (s/n) -->> " sn
            echo -e "${borra_colores}"
            if [[ $sn = "s" ]] || [[ $sn = "S" ]]
            then
                rm /home/$(whoami)/.config/control_bd_digikam.sukigsx
                if [ -f /home/$(whoami)/.config/control_bd_digikam.sukigsx ]
                then
                    echo -e ""
                    echo -e "${rojo} No ha sido posible la eliminacion del fichero de configuracion.${borra_colores}"
                    echo -e " Pulsa una tecla para continuar."
                    read pause
                else
                    echo -e ""
                    echo -e "${verde} Fichero eliminado.${borra_colores}"
                    echo -e ""
                    sleep 2
                    echo -e "${rosa} Necesario configurar el script "${borra_colores}
                    sleep 2
                    configuracion_script
                fi
            else
                echo -e ""
                echo -e "${amarillo} No se elimina nada.${borra_colores}"
                sleep 2
            fi;;

        6)  #Borrar la configuracion de digikam (base de datos y ficheros de configuracion).
            read -p " ¿Seguro que quieres eliminarlo? (s/n) -->> " sn
            echo -e "${borra_colores}"
            if [[ $sn = "s" ]] || [[ $sn = "S" ]]
            then
                rm $baselocal/*
                rm /home/$(whoami)/.config/digikamrc
                echo -e "${verde} Configuracion de digikam y ficheros borrados.${borra_colores}"
            else
                echo -e "${amarillo} No se borra nada.${borra_colores}"
                sleep 3
            fi;;


        7)  echo "has seleccionado la tres";
            read p;;

        90) #ayuda
            echo "ayuda";
            read p;;

        99)  ctrl_c;;

        *)  echo -e "${amarillo}Opcion no valida.";
            sleep 3;;
esac
done














