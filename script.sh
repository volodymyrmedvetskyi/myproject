#!/usr/bin/env bash
# feature-2 comment
# Визначаємо дистрибутив та результат записуємо у змінну distro
distro=$(hostnamectl | grep 'Operating System' | awk -F': ' '{print $2}' | awk '{print $1}')
# Створюємо масив для установки заданих пакетів для Ubuntu
ubuntu_packages=("apache2" "mariadb-server" "ufw" "docker")
# Створюємо масив для установки заданих пакетів для CentOS та Fedora
centos_fedora_packages=("httpd" "mariadb-server" "firewalld" "docker")

# Викликаємо цикл for для пакетів, що будуть вказані при запуску
for arg in "$@"; do
  ubuntu_packages+=("$arg")
  centos_fedora_packages+=("$arg")
done

# Створюємо функцію для перевірки оновлення та установки пакетів, які ще не встановлені для Ubuntu
ubuntu(){
  for i in "${ubuntu_packages[@]}"; do
    if dpkg -l | grep "ii  $i" > /dev/null; then
      echo "####################################################"
      echo "$i package needs to be updated. Updating..."
      sudo apt-get upgrade -y > /dev/null
      echo "Update of $i is done!"
      echo "####################################################"
      echo
    else
      echo "####################################################"
      echo "$i package needs to be installed. Installing..."
      sudo apt-get install "$i" -y > /dev/null
      echo "Installing of $i is done!"
      echo "####################################################"
      echo
    fi
  done
}

# Створюємо функцію для перевірки оновлення та установки пакетів, які ще не встановлені для CentOS
centos(){
  for i in "${centos_fedora_packages[@]}"; do
    if rpm -qa | grep "$i" > /dev/null; then
      echo "####################################################"
      echo "$i package needs to be updated. Updating..."
      sudo yum update -y > /dev/null
      echo "Update of $i is done!"
      echo "####################################################"
      echo
    else
      echo "####################################################"
      echo "$i package needs to be installed. Installing..."
      sudo yum install "$i" -y > /dev/null
      echo "Installing of $i is done!"
      echo "####################################################"
      echo
    fi
  done
}

# Створюємо функцію для перевірки оновлення та установки пакетів, які ще не встановлені для Fedora
fedora(){
  for i in "${centos_fedora_packages[@]}"; do
    if rpm -qa | grep "$i" > /dev/null; then
      echo "####################################################"
      echo "$i package needs to be updated. Updating..."
      sudo dnf update -y > /dev/null
      echo "Update of $i is done!"
      echo "####################################################"
      echo
    else
      echo "####################################################"
      echo "$i package needs to be installed. Installing..."
      sudo dnf install "$i" -y > /dev/null
      echo "Installing of $i is done!"
      echo "####################################################"
      echo
    fi
  done
}

# Створюємо конструкцію case: визначивши, який саме дистрибутив Linux встановлено, викликаємо відповідну функцію
case $distro in
  Ubuntu)
    echo "###########################################"
    echo "Your Distro is $distro"
    echo "###########################################"
    echo
    sudo apt-get update > /dev/null
    ubuntu
    echo "All packages was updated and installed successfully!"
    echo
    ;;
  CentOS)
    echo "###########################################"
    echo "Your Distro is $distro"
    echo "###########################################"
    echo
    centos
    echo "All packages was updated and installed successfully!"
    echo
    ;;
  Fedora)
    echo "###########################################"
    echo "Your Distro is $distro"
    echo "###########################################"
    echo
    fedora
    echo "All packages was updated and installed successfully!"
    echo
    ;;
  *)
    echo "Unknown Distro"
esac
