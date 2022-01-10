!#/bin/bash

x=0
y=0

rm carte-titi-projet-M3102.dot
rm carte-titi-projet-M3102.png
rm carte-titi-projet-M3102.txt
rm dot-titi-projet-M3102
rm dot2-titi-projet-M3102

echo "digraph {" > dot-titi-projet-M3102.txt
echo "  Protocols -> UDP" >> dot-titi-projet-M3102.txt
echo "  Protocols -> TCP" >> dot-titi-projet-M3102.txt
echo "  UDP -> Time_Protocol [color=red]" >> dot-titi-projet-M3102.txt #37
echo "  UDP -> DNS [color=orange]" >> dot-titi-projet-M3102.txt #53
echo "  UDP -> HTTP [color=yellow]" >> dot-titi-projet-M3102.txt #80
echo "  UDP -> RIP [color=green]" >> dot-titi-projet-M3102.txt #520
echo "  UDP -> RADIUS_accounting_protocol [color=blue]" >> dot-titi-projet-M3102.txt #1813
echo "  UDP -> MQTT [color=purple]" >> dot-titi-projet-M3102.txt #1883
echo "  UDP -> AWS [color=pink]" >> dot-titi-projet-M3102.txt #4195
echo "  TCP -> FTP_data_transfer [color=brown]" >> dot-titi-projet-M3102.txt #20
echo "  TCP -> Telnet_over_TLS_SSL [color=chartreuse]" >> dot-titi-projet-M3102.txt #992
echo "  TCP -> SMTP [color=crimson]" >> dot-titi-projet-M3102.txt #25
echo "  TCP -> Time_Protocol [color=red3]" >> dot-titi-projet-M3102.txt #37
echo "  TCP -> DNS [color=orange3]" >> dot-titi-projet-M3102.txt #53
echo "  TCP -> HTTP [color=yellow3]" >> dot-titi-projet-M3102.txt #80
echo "  TCP -> SMTP_chiffrement_explicite [color=grey]" >> dot-titi-projet-M3102.txt #587
echo "  TCP -> DHCP_Failover [color=violet]" >> dot-titi-projet-M3102.txt #647
echo "  TCP -> RADIUS_accounting_protocol [color=blue4]" >> dot-titi-projet-M3102.txt #1813
echo "  TCP -> MQTT [color=purple3]" >> dot-titi-projet-M3102.txt #1883
echo "  TCP -> GNUnet [color=fuchsia]" >> dot-titi-projet-M3102.txt #2086
echo "  TCP -> Docker_REST_API_plain [color=gold]" >> dot-titi-projet-M3102.txt #2375
echo "  TCP -> AWS [color=pink3]" >> dot-titi-projet-M3102.txt #4195

push-dot () {	
	traceroute -n $1 -p $2 -A $i | tr -d '*' | cut -c 3- | tail -n +2 | cut -d " " -f 3-5 | tr -d ' ' | sed '/^[[:space:]]*$/d' > carte-titi-projet-M3102.txt
	src="Mon PC"
	carte=$(cat carte-titi-projet-M3102.txt)
	rm carte-titi-projet-M3102.txt
	for z in $carte
	do
	        echo "  "\"$src"\" -> "\"$z"\" [color="\"$3"\"]" >> dot-titi-projet-M3102.txt 
	        src=$z
	done
	echo "}" >> dot-titi-projet-M3102.txt

	cat dot-titi-projet-M3102.txt > carte-titi-projet-M3102.dot
	sed 's/}//' dot-titi-projet-M3102.txt > dot2-titi-projet-M3102.txt 
	sed "/^ *$/d" dot2-titi-projet-M3102.txt > dot-titi-projet-M3102.txt
	rm dot2-titi-projet-M3102.txt

	rm carte-titi-projet-M3102.png
	cat carte-titi-projet-M3102.dot | dot -T png > carte-titi-projet-M3102.png

	y=$(($y + 1))

	echo "Le traceroute $y/$t de $1 sur le port $2 est terminé, vous pouvez consulter la carte ce trouvant dans ce dossier."
}

final-push () {
	push-dot -T 20 brown
	push-dot -T 25 crimson
	push-dot -T 37 red3
	push-dot -U 37 red
	push-dot -T 992 chartreuse
	push-dot -T 53 orange3
	push-dot -U 53 orange
	push-dot -T 80 yellow3
	push-dot -U 80 yellow
	push-dot -U 520 green
	push-dot -T 587 grey
	push-dot -T 647 violet
	push-dot -T 1813 blue4
	push-dot -U 1813 blue
	push-dot -T 1883 purple3
	push-dot -U 1883 purple
	push-dot -T 2086 fuchsia
	push-dot -T 2375 gold
	push-dot -T 4195 pink3
	push-dot -U 4195 pink
}

echo "Combien d'adresse voulez-vous faire un traceroute ?"
read nb
t=$(($nb * 20))

while [ $x != $nb ]
do
	echo "À quelle adresse il faut faire un traceroute ?"
	# les adresses : www.iutbeziers.fr ; www.umontpellier.fr ; www.google.fr

	read addr
	echo $addr >> addr-titi-projet-M3102.txt
	x=$(($x + 1))
done

add=$(cat addr-titi-projet-M3102.txt)
rm addr-titi-projet-M3102.txt

for i in $add
do
	final-push
done

rm dot-titi-projet-M3102.txt
rm carte-titi-projet-M3102.dot
