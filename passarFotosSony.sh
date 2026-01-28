echo "Passando fotos"
cp -n /run/media/georgios/disk/DCIM/100MSDCF/*.JPG /home/georgios/Imagens/Fotos/Sony\ Cyber-Shot\ DSC\ WX7/ || echo "Sem fotos para passar"
echo "Passando vídeos"
cp -n /run/media/georgios/disk/MP_ROOT/100ANV01/*.MP4 /home/georgios/Vídeos/"Sony DSC-WX7"/ || echo "Sem vídeos para passar"

read -p "Quer sincronizar com o celular? (Ligue o sshd no Termux) [Y/n]: " resposta

if [[ "$resposta" == "y" || "$resposta" == Y || -z "$resposta" ]]; then
  echo "Sincronizando fotos por SSH"
  read -p "Digite o IP(Utilizando pontos): " IP
  rsync -vrtzP -e "ssh -p 8022" --ignore-existing ~/Imagens/Fotos/"Sony Cyber-Shot DSC WX7"/*.JPG u0_a308@$IP:/sdcard/DCIM/"Sony Cyber-Shot" || echo "Erro ao sincronizar fotos"
  echo "Sincronizando videos por SSH"
  rsync -vrtzP -e "ssh -p 8022" --ignore-existing ~/Vídeos/"Sony DSC-WX7"/*.MP4 u0_a308@$IP:/sdcard/DCIM/"Sony Cyber-Shot" || echo "Erro ao sincronizar vídeos" 
  echo "Concluído"
else
  echo "Ok."
fi

  read -p "Apagar as fotos e vídeos da câmera? [Y/n]: " resposta 

if [[ "$resposta" == "y" || "$resposta" == Y || -z "$resposta" ]]; then
  echo "Apagando..."
  rm /run/media/georgios/disk/DCIM/100MSDCF/*.JPG
  rm /run/media/georgios/disk/MP_ROOT/100ANV01/*.MP4
  rm /run/media/georgios/disk/MP_ROOT/100ANV01/*.THM
  echo "Apagado com sucesso"
else
  echo "Ok."
fi
