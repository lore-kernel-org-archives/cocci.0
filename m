From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 13 Oct 2015 07:33:01 +0200 (CEST)
Subject: [Cocci] elision of unneeded parens
In-Reply-To: <CAP6exYKikd_mkcewXF10Ch7J-LWSVXKuuxNu3Eo3Aek6rUANBQ@mail.gmail.com>
References: <CAP6exY+Mzdo=_hNUksjCfYPVKU6Fx0TgJRUZuVw8K15Y0Yo1mA@mail.gmail.com>
 <CA+MoWDp13SaQHQSCkf50WvQWMB1E3v_0kTFs94HbJ3onw4-SuA@mail.gmail.com>
 <CAP6exYLMymc3OeLMDJfvu5xkPUZe8UGRDNGfufMM-c=VUONd9A@mail.gmail.com>
 <CA+MoWDoJan191KVHOYvRCLGSP56co9NsfjcxCF=eLUtjUZpsGg@mail.gmail.com>
 <CA+MoWDqt19jGAiiz27guRq==3gC8fF7GfdAsAKSXEjoTGk1A0Q@mail.gmail.com>
 <CAP6exYKikd_mkcewXF10Ch7J-LWSVXKuuxNu3Eo3Aek6rUANBQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1510130720100.2063@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

This seems to work pretty well.  Unfortunately, the spacing is not as nice 
as one would hope for showing off to someone else.

@@
binary operator op = {==,!=};
expression e1,e2,e3,e4,e5;
@@

(
 (e3 || e4)
|
-(
e1 op e2
-)
)
 &&
 e5

@@
binary operator op = {==,!=};
expression e1,e2,e3,e4,e5;
@@

 e5
 &&
(
 (e3 || e4)
|
-(
  e1 op e2
-)
)

-----------------------------------------------------

int main () {
  if ((a == b) && (c != d)) return 12;
  if ((a == b) && (c != d) && (c == d)) return 12;
  if (a == b && (c != d)) return 12;
  if (a == b && (c != d) && (c == d)) return 12;
  if ((a == b) && c != d) return 12;
  if ((a == b) && c != d && (c == d)) return 12;
  if ((a == b) && (c != d) && c == d) return 12;
  if ((a == b) && c != d && c == d) return 12;
  if (a == b && (c != d) && c == d) return 12;
  if ((a == b) + c) return 12;  // should not change
}
