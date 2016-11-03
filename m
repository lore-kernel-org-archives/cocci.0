From: waldemar.rymarkiewicz@gmail.com (Waldemar Rymarkiewicz)
Date: Thu, 3 Nov 2016 17:06:53 +0100
Subject: [Cocci] Manipulate identifier like a string ?
Message-ID: <CAHKzcENGfx+Q9fUQ_47waCMaJ6nC88Uip7uuF1nZ7=kPdEkUpQ@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

Wondering if there is a quick solution in cocci to replace a suffix in
a group of identifiers?

I need something like this

@@
identifier  id  =~ "^XXX_.*";       // say it matches XXX_foo and XXX_bar
fresh identifier xx =  "YYY" ##  id[3:]      // where id[:3]  takes
string starting at position 3

@@
-id
+xx


or is that possible to manipulate identifier in python  and pas it
back to cocci ?


Thanks,
/Waldek
