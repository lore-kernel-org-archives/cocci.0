Return-Path: <SRS0=VaV3=27=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7ADC33CA5
	for <cocci@archiver.kernel.org>; Fri, 10 Jan 2020 15:30:09 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BAE22082E
	for <cocci@archiver.kernel.org>; Fri, 10 Jan 2020 15:30:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BAE22082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=orange.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00AFTrhb002157;
	Fri, 10 Jan 2020 16:29:53 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 323A577EA;
	Fri, 10 Jan 2020 16:29:53 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id F1DD477E3
 for <cocci@systeme.lip6.fr>; Fri, 10 Jan 2020 16:00:32 +0100 (CET)
Received: from relais-inet.orange.com (relais-inet.orange.com [80.12.66.41])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00AF0Vj7012323
 for <cocci@systeme.lip6.fr>; Fri, 10 Jan 2020 16:00:31 +0100 (CET)
Received: from opfedar03.francetelecom.fr (unknown [xx.xx.xx.5])
 by opfedar24.francetelecom.fr (ESMTP service) with ESMTP id 47vR4H5MWCz5vgj;
 Fri, 10 Jan 2020 16:00:31 +0100 (CET)
Received: from meplus-smtp.si.francetelecom.fr (unknown [10.98.78.74])
 by opfedar03.francetelecom.fr (ESMTP service) with ESMTP id 47vR4H4Dr5zCqkS;
 Fri, 10 Jan 2020 16:00:31 +0100 (CET)
Received: from meplus.info (localhost [127.0.0.1])
 by mwinf8806.smtpft.francetelecom.fr (SMTP Server) with ESMTP id 83F731C0A8F2; 
 Fri, 10 Jan 2020 16:00:31 +0100 (CET)
Received: from EBOR6152715 (unknown [10.146.98.23])
 by mwinf8806.smtpft.francetelecom.fr (SMTP Server) with ESMTP id 4ED6B1C0A8C5; 
 Fri, 10 Jan 2020 16:00:31 +0100 (CET)
X-ME-UUID: 20200110150031323.4ED6B1C0A8C5@mwinf8806.smtpft.francetelecom.fr
From: <samir.abed@orange.com>
To: <cocci@systeme.lip6.fr>
Date: Fri, 10 Jan 2020 16:00:31 +0100
Message-ID: <20199_1578668431_5E18918F_20199_450_3_009301d5c7c6$b3f927c0$1beb7740$@orange.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AdXHwztMyMJJXwxpRKybclpwEjHcSA==
Content-Language: fr
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 10 Jan 2020 16:29:53 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 10 Jan 2020 16:00:31 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Fri, 10 Jan 2020 16:29:51 +0100
Cc: permissions-commons@wikimedia.org
Subject: [Cocci] Coccinelle (software): Request for permission to use on
	Wikipedia
X-BeenThere: cocci@systeme.lip6.fr
X-Mailman-Version: 2.1.13
Precedence: list
List-Id: <cocci.systeme.lip6.fr>
List-Unsubscribe: <https://systeme.lip6.fr/mailman/options/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=unsubscribe>
List-Archive: <https://systeme.lip6.fr/pipermail/cocci>
List-Post: <mailto:cocci@systeme.lip6.fr>
List-Help: <mailto:cocci-request@systeme.lip6.fr?subject=help>
List-Subscribe: <https://systeme.lip6.fr/mailman/listinfo/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1373509630=="
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

This is a multipart message in MIME format.


--===============1373509630==
Content-Type: multipart/related;
	boundary="----=_NextPart_000_0094_01D5C7CF.15C99DB0"
Content-Language: fr

This is a multipart message in MIME format.


------=_NextPart_000_0094_01D5C7CF.15C99DB0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_0095_01D5C7CF.15C9C4C0"


------=_NextPart_001_0095_01D5C7CF.15C9C4C0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,

=20

I am a volunteer editor from Wikipedia. I am working on the Coccinelle
(software) article which currently has no images.

I found your page  <http://coccinelle.lip6.fr/> http://coccinelle.lip6.fr/,
and thought your images might be appropriate for inclusion in my article
concerning Coccinelle (software).

I am specifically seeking your permission to use these Coccinelle=92s logos:
 <http://coccinelle.lip6.fr/img/CoccinelleLinux6_s.jpg>
http://coccinelle.lip6.fr/img/CoccinelleLinux6_s.jpg

http://coccinelle.lip6.fr/img/CoccinelleInside_s.jpg

I would like to include your image in my article under construction:
 <https://fr.wikipedia.org/wiki/Utilisateur:Samir86/Brouillon>
https://fr.wikipedia.org/wiki/Utilisateur:Samir86/Brouillon

=20

If you are able and would agree to provide a freely licensed image (it need
not be newly created) for use on Wikimedia projects, please follow the
instructions at
<https://commons.wikimedia.org/wiki/Commons:Email_templates>
https://commons.wikimedia.org/wiki/Commons:Email_templates, or alternately,
email the photo and consent text from that page to
permissions-commons@wikimedia.org, or to myself at samir.abed@orange.com.

=20

=20

Wikipedia ( <https://www.wikipedia.org/> https://www.wikipedia.org/) is a
free encyclopedia that is collaboratively edited by volunteers from around
the world. Our goal is to create a comprehensive knowledge base that may be
freely distributed and available at no charge.

Normally we ask permission for material to be used under the terms of the
Creative Commons Attribution-Sharealike 3.0 Unported License. This means
that although you retain the copyright and authorship of your own work, you
are granting permission for all others (not just Wikipedia) to use, copy,
and share your materials freely =97 and even potentially use them commercia=
lly
=97 so long as they do not try to claim the copyright themselves, nor preve=
nt
others from using or copying them freely.

You can read this license in full at:
=20
<https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attributio
n-ShareAlike_3.0_Unported_License>
https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution
-ShareAlike_3.0_Unported_License

This license expressly protects creators from being considered responsible
for modifications made by others, while ensuring that creators are credited
for their work. There is more information on our copyright policy at:
 <https://en.wikipedia.org/wiki/Wikipedia:Copyrights>
http://en.wikipedia.org/wiki/Wikipedia:Copyrights

We choose the Creative Commons Attribution-Sharealike 3.0 Unported License
because we consider it the best available tool for ensuring our encyclopedia
can remain free for all to use, while providing credit to everyone who
donates text and images. This may or may not be compatible with your goals
in creating the materials available on your website. Please be assured that
if permission is not granted, your materials will not be used at Wikipedia =
=97
we have a very strict policy against copyright violations.

We also accept licensing of images under other free-content licenses. See
<https://en.wikipedia.org/wiki/Wikipedia:Image_copyright_tags>
https://en.wikipedia.org/wiki/Wikipedia:Image_copyright_tags

With your permission, we will credit you for your work in the image's
permanent description page, noting that it is your work and is used with
your permission, and we will provide a link back to your website. Please
explicitly state under which license you grant permission.

We invite your collaboration in writing and editing articles on this subject
and any others that might interest you. Please see the following article for
more information.
 <https://en.wikipedia.org/wiki/Wikipedia:Introduction>
https://en.wikipedia.org/wiki/Wikipedia:Introduction

Thank you for your time.

=20

Best regards,

=20

 <http://www.orange.com/> Logo Orange

=20

Samir Abed=20
Expert en ing=E9nierie de l=92exploitation=20
ORANGE/OF/DTSI/DERS/DR/DRM/RMC/ETI=20

=20

Fixe :
<https://monsi.sso.francetelecom.fr/index.asp?target=3Dhttp%3A%2F%2Fclicvoi=
ce.
sso.francetelecom.fr%2FClicvoiceV2%2FToolBar.do%3Faction%3Ddefault%26rootser
vice%3DSIGNATURE%26to%3D+33%204%2037%2045%2060%2066> +33 4 37 45 60 66=20
Mobile :
<https://monsi.sso.francetelecom.fr/index.asp?target=3Dhttp%3A%2F%2Fclicvoi=
ce.
sso.francetelecom.fr%2FClicvoiceV2%2FToolBar.do%3Faction%3Ddefault%26rootser
vice%3DSIGNATURE%26to%3D+33%206%2043%2061%2039%2030> +33 6 43 61 39 30=20
 <mailto:samir.abed@orange.com> samir.abed@orange.com

=20


___________________________________________________________________________=
______________________________________________

Ce message et ses pieces jointes peuvent contenir des informations confiden=
tielles ou privilegiees et ne doivent donc
pas etre diffuses, exploites ou copies sans autorisation. Si vous avez recu=
 ce message par erreur, veuillez le signaler
a l'expediteur et le detruire ainsi que les pieces jointes. Les messages el=
ectroniques etant susceptibles d'alteration,
Orange decline toute responsabilite si ce message a ete altere, deforme ou =
falsifie. Merci.

This message and its attachments may contain confidential or privileged inf=
ormation that may be protected by law;
they should not be distributed, used or copied without authorisation.
If you have received this email in error, please notify the sender and dele=
te this message and its attachments.
As emails may be altered, Orange is not liable for messages that have been =
modified, changed or falsified.
Thank you.


------=_NextPart_001_0095_01D5C7CF.15C9C4C0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40"><head><meta http-equiv=3DContent-Type content=
=3D"text/html; charset=3Diso-8859-1"><meta name=3DGenerator content=3D"Micr=
osoft Word 14 (filtered medium)"><!--[if !mso]><style>v\:* {behavior:url(#d=
efault#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";
	mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p
	{mso-style-priority:99;
	mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-priority:99;
	mso-style-link:"Texte de bulles Car";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:8.0pt;
	font-family:"Tahoma","sans-serif";
	mso-fareast-language:EN-US;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.TextedebullesCar
	{mso-style-name:"Texte de bulles Car";
	mso-style-priority:99;
	mso-style-link:"Texte de bulles";
	font-family:"Tahoma","sans-serif";}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:70.85pt 70.85pt 70.85pt 70.85pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DFR link=3Dblue vlink=
=3Dpurple><div class=3DWordSection1><p style=3D'mso-margin-top-alt:6.0pt;ma=
rgin-right:0cm;margin-bottom:6.0pt;margin-left:0cm;background:white'><span =
lang=3DEN-US style=3D'font-size:10.5pt;font-family:"Arial","sans-serif";col=
or:#222222'>Hello,<o:p></o:p></span></p><p style=3D'mso-margin-top-alt:6.0p=
t;margin-right:0cm;margin-bottom:6.0pt;margin-left:0cm;background:white'><s=
pan lang=3DEN-US style=3D'font-size:10.5pt;font-family:"Arial","sans-serif"=
;color:#222222'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=
=3DEN-US style=3D'font-size:10.5pt;font-family:"Arial","sans-serif";color:#=
222222'>I am a volunteer editor from Wikipedia. I am working on the Coccine=
lle (software) article which currently has no images.</span><span lang=3DEN=
-US><o:p></o:p></span></p><p style=3D'mso-margin-top-alt:6.0pt;margin-right=
:0cm;margin-bottom:6.0pt;margin-left:0cm;background:white'><span lang=3DEN-=
US style=3D'font-size:10.5pt;font-family:"Arial","sans-serif";color:#222222=
'>I found your page </span><a href=3D"http://coccinelle.lip6.fr/"><span lan=
g=3DEN-US>http://coccinelle.lip6.fr/</span></a><span lang=3DEN-US style=3D'=
font-size:10.5pt;font-family:"Arial","sans-serif";color:#222222'>, and thou=
ght your images might be appropriate for inclusion in my article concerning=
 Coccinelle (software).<o:p></o:p></span></p><p style=3D'mso-margin-top-alt=
:6.0pt;margin-right:0cm;margin-bottom:6.0pt;margin-left:0cm;background:whit=
e;font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;text-=
align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-style:=
 initial;text-decoration-color: initial;word-spacing:0px'><span lang=3DEN-U=
S style=3D'font-size:10.5pt;font-family:"Arial","sans-serif";color:#222222'=
>I am specifically seeking your permission to use these Coccinelle&#8217;s =
logos:<br></span><a href=3D"http://coccinelle.lip6.fr/img/CoccinelleLinux6_=
s.jpg"><span lang=3DEN-US>http://coccinelle.lip6.fr/img/CoccinelleLinux6_s.=
jpg</span></a><span lang=3DEN-US><o:p></o:p></span></p><p style=3D'mso-marg=
in-top-alt:6.0pt;margin-right:0cm;margin-bottom:6.0pt;margin-left:0cm;backg=
round:white'><a href=3D"http://coccinelle.lip6.fr/img/CoccinelleInside_s.jp=
g">http://coccinelle.lip6.fr/img/CoccinelleInside_s.jpg</a><span style=3D'f=
ont-size:10.5pt;font-family:"Arial","sans-serif";color:#222222'><o:p></o:p>=
</span></p><p style=3D'mso-margin-top-alt:6.0pt;margin-right:0cm;margin-bot=
tom:6.0pt;margin-left:0cm;background:white;font-variant-ligatures: normal;f=
ont-variant-caps: normal;orphans: 2;text-align:start;widows: 2;-webkit-text=
-stroke-width: 0px;text-decoration-style: initial;text-decoration-color: in=
itial;word-spacing:0px'><span lang=3DEN-US style=3D'font-size:10.5pt;font-f=
amily:"Arial","sans-serif";color:#222222'>I would like to include your imag=
e in my article under construction:<br></span><a href=3D"https://fr.wikiped=
ia.org/wiki/Utilisateur:Samir86/Brouillon"><span lang=3DEN-US>https://fr.wi=
kipedia.org/wiki/Utilisateur:Samir86/Brouillon</span></a><span lang=3DEN-US=
><o:p></o:p></span></p><p style=3D'mso-margin-top-alt:6.0pt;margin-right:0c=
m;margin-bottom:6.0pt;margin-left:0cm;background:white'><span lang=3DEN-US =
style=3D'font-size:10.5pt;font-family:"Arial","sans-serif";color:#222222'><=
o:p>&nbsp;</o:p></span></p><p style=3D'mso-margin-top-alt:6.0pt;margin-righ=
t:0cm;margin-bottom:6.0pt;margin-left:0cm;background:white'><span lang=3DEN=
-US style=3D'font-size:10.5pt;font-family:"Arial","sans-serif";color:#22222=
2;background:white'>If you are able and would agree to provide a freely lic=
ensed image (it need not be newly created) for use on Wikimedia projects, p=
lease follow the instructions at&nbsp;</span><a href=3D"https://commons.wik=
imedia.org/wiki/Commons:Email_templates"><span lang=3DEN-US style=3D'font-s=
ize:10.5pt;font-family:"Arial","sans-serif";color:#663366;text-decoration:n=
one'>https://commons.wikimedia.org/wiki/Commons:Email_templates</span></a><=
span lang=3DEN-US style=3D'font-size:10.5pt;font-family:"Arial","sans-serif=
";color:#222222;background:white'>, or alternately, email the photo and con=
sent text from that page to permissions-commons@wikimedia.org, or to myself=
 at samir.abed@orange.com.</span><span lang=3DEN-US style=3D'font-size:10.5=
pt;font-family:"Arial","sans-serif";color:#222222'><o:p></o:p></span></p><p=
 style=3D'mso-margin-top-alt:6.0pt;margin-right:0cm;margin-bottom:6.0pt;mar=
gin-left:0cm;background:white'><span lang=3DEN-US style=3D'font-size:10.5pt=
;font-family:"Arial","sans-serif";color:#222222'><o:p>&nbsp;</o:p></span></=
p><p style=3D'mso-margin-top-alt:6.0pt;margin-right:0cm;margin-bottom:6.0pt=
;margin-left:0cm;background:white'><span lang=3DEN-US style=3D'font-size:10=
.5pt;font-family:"Arial","sans-serif";color:#222222'><o:p>&nbsp;</o:p></spa=
n></p><p style=3D'mso-margin-top-alt:6.0pt;margin-right:0cm;margin-bottom:6=
.0pt;margin-left:0cm;background:white;font-variant-ligatures: normal;font-v=
ariant-caps: normal;orphans: 2;text-align:start;widows: 2;-webkit-text-stro=
ke-width: 0px;text-decoration-style: initial;text-decoration-color: initial=
;word-spacing:0px'><span lang=3DEN-US style=3D'font-size:10.5pt;font-family=
:"Arial","sans-serif";color:#222222'>Wikipedia (</span><span style=3D'font-=
size:10.5pt;font-family:"Arial","sans-serif";color:#222222'><a href=3D"http=
s://www.wikipedia.org/"><span lang=3DEN-US style=3D'color:#663366;text-deco=
ration:none'>https://www.wikipedia.org/</span></a></span><span lang=3DEN-US=
 style=3D'font-size:10.5pt;font-family:"Arial","sans-serif";color:#222222'>=
) is a free encyclopedia that is collaboratively edited by volunteers from =
around the world. Our goal is to create a comprehensive knowledge base that=
 may be freely distributed and available at no charge.<o:p></o:p></span></p=
><p style=3D'mso-margin-top-alt:6.0pt;margin-right:0cm;margin-bottom:6.0pt;=
margin-left:0cm;background:white;font-variant-ligatures: normal;font-varian=
t-caps: normal;orphans: 2;text-align:start;widows: 2;-webkit-text-stroke-wi=
dth: 0px;text-decoration-style: initial;text-decoration-color: initial;word=
-spacing:0px'><span lang=3DEN-US style=3D'font-size:10.5pt;font-family:"Ari=
al","sans-serif";color:#222222'>Normally we ask permission for material to =
be used under the terms of the Creative Commons Attribution-Sharealike 3.0 =
Unported License. This means that although you retain the copyright and aut=
horship of your own work, you are granting permission for all others (not j=
ust Wikipedia) to use, copy, and share your materials freely &#8212; and ev=
en potentially use them commercially &#8212; so long as they do not try to =
claim the copyright themselves, nor prevent others from using or copying th=
em freely.<o:p></o:p></span></p><p style=3D'mso-margin-top-alt:6.0pt;margin=
-right:0cm;margin-bottom:6.0pt;margin-left:0cm;background:white;font-varian=
t-ligatures: normal;font-variant-caps: normal;orphans: 2;text-align:start;w=
idows: 2;-webkit-text-stroke-width: 0px;text-decoration-style: initial;text=
-decoration-color: initial;word-spacing:0px'><span lang=3DEN-US style=3D'fo=
nt-size:10.5pt;font-family:"Arial","sans-serif";color:#222222'>You can read=
 this license in full at:<br></span><span style=3D'font-size:10.5pt;font-fa=
mily:"Arial","sans-serif";color:#222222'><a href=3D"https://en.wikipedia.or=
g/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unport=
ed_License"><span lang=3DEN-US style=3D'color:#663366;text-decoration:none'=
>https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attributi=
on-ShareAlike_3.0_Unported_License</span></a></span><span lang=3DEN-US styl=
e=3D'font-size:10.5pt;font-family:"Arial","sans-serif";color:#222222'><o:p>=
</o:p></span></p><p style=3D'mso-margin-top-alt:6.0pt;margin-right:0cm;marg=
in-bottom:6.0pt;margin-left:0cm;background:white;font-variant-ligatures: no=
rmal;font-variant-caps: normal;orphans: 2;text-align:start;widows: 2;-webki=
t-text-stroke-width: 0px;text-decoration-style: initial;text-decoration-col=
or: initial;word-spacing:0px'><span lang=3DEN-US style=3D'font-size:10.5pt;=
font-family:"Arial","sans-serif";color:#222222'>This license expressly prot=
ects creators from being considered responsible for modifications made by o=
thers, while ensuring that creators are credited for their work. There is m=
ore information on our copyright policy at:<br></span><span style=3D'font-s=
ize:10.5pt;font-family:"Arial","sans-serif";color:#222222'><a href=3D"https=
://en.wikipedia.org/wiki/Wikipedia:Copyrights"><span lang=3DEN-US style=3D'=
color:#663366;text-decoration:none'>http://en.wikipedia.org/wiki/Wikipedia:=
Copyrights</span></a></span><span lang=3DEN-US style=3D'font-size:10.5pt;fo=
nt-family:"Arial","sans-serif";color:#222222'><o:p></o:p></span></p><p styl=
e=3D'mso-margin-top-alt:6.0pt;margin-right:0cm;margin-bottom:6.0pt;margin-l=
eft:0cm;background:white;font-variant-ligatures: normal;font-variant-caps: =
normal;orphans: 2;text-align:start;widows: 2;-webkit-text-stroke-width: 0px=
;text-decoration-style: initial;text-decoration-color: initial;word-spacing=
:0px'><span lang=3DEN-US style=3D'font-size:10.5pt;font-family:"Arial","san=
s-serif";color:#222222'>We choose the Creative Commons Attribution-Shareali=
ke 3.0 Unported License because we consider it the best available tool for =
ensuring our encyclopedia can remain free for all to use, while providing c=
redit to everyone who donates text and images. This may or may not be compa=
tible with your goals in creating the materials available on your website. =
Please be assured that if permission is not granted, your materials will no=
t be used at Wikipedia &#8212; we have a very strict policy against copyrig=
ht violations.<o:p></o:p></span></p><p style=3D'mso-margin-top-alt:6.0pt;ma=
rgin-right:0cm;margin-bottom:6.0pt;margin-left:0cm;background:white;font-va=
riant-ligatures: normal;font-variant-caps: normal;orphans: 2;text-align:sta=
rt;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-style: initial;=
text-decoration-color: initial;word-spacing:0px'><span lang=3DEN-US style=
=3D'font-size:10.5pt;font-family:"Arial","sans-serif";color:#222222'>We als=
o accept licensing of images under other free-content licenses. See&nbsp;</=
span><span style=3D'font-size:10.5pt;font-family:"Arial","sans-serif";color=
:#222222'><a href=3D"https://en.wikipedia.org/wiki/Wikipedia:Image_copyrigh=
t_tags"><span lang=3DEN-US style=3D'color:#663366;text-decoration:none'>htt=
ps://en.wikipedia.org/wiki/Wikipedia:Image_copyright_tags</span></a></span>=
<span lang=3DEN-US style=3D'font-size:10.5pt;font-family:"Arial","sans-seri=
f";color:#222222'><o:p></o:p></span></p><p style=3D'mso-margin-top-alt:6.0p=
t;margin-right:0cm;margin-bottom:6.0pt;margin-left:0cm;background:white;fon=
t-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;text-align=
:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-style: init=
ial;text-decoration-color: initial;word-spacing:0px'><span lang=3DEN-US sty=
le=3D'font-size:10.5pt;font-family:"Arial","sans-serif";color:#222222'>With=
 your permission, we will credit you for your work in the image's permanent=
 description page, noting that it is your work and is used with your permis=
sion, and we will provide a link back to your website. Please explicitly st=
ate under which license you grant permission.<o:p></o:p></span></p><p style=
=3D'mso-margin-top-alt:6.0pt;margin-right:0cm;margin-bottom:6.0pt;margin-le=
ft:0cm;background:white;font-variant-ligatures: normal;font-variant-caps: n=
ormal;orphans: 2;text-align:start;widows: 2;-webkit-text-stroke-width: 0px;=
text-decoration-style: initial;text-decoration-color: initial;word-spacing:=
0px'><span lang=3DEN-US style=3D'font-size:10.5pt;font-family:"Arial","sans=
-serif";color:#222222'>We invite your collaboration in writing and editing =
articles on this subject and any others that might interest you. Please see=
 the following article for more information.<br></span><span style=3D'font-=
size:10.5pt;font-family:"Arial","sans-serif";color:#222222'><a href=3D"http=
s://en.wikipedia.org/wiki/Wikipedia:Introduction"><span lang=3DEN-US style=
=3D'color:#663366;text-decoration:none'>https://en.wikipedia.org/wiki/Wikip=
edia:Introduction</span></a></span><span lang=3DEN-US style=3D'font-size:10=
.5pt;font-family:"Arial","sans-serif";color:#222222'><o:p></o:p></span></p>=
<p style=3D'mso-margin-top-alt:6.0pt;margin-right:0cm;margin-bottom:6.0pt;m=
argin-left:0cm;background:white;font-variant-ligatures: normal;font-variant=
-caps: normal;orphans: 2;text-align:start;widows: 2;-webkit-text-stroke-wid=
th: 0px;text-decoration-style: initial;text-decoration-color: initial;word-=
spacing:0px'><span lang=3DEN-US style=3D'font-size:10.5pt;font-family:"Aria=
l","sans-serif";color:#222222'>Thank you for your time.<o:p></o:p></span></=
p><p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p cl=
ass=3DMsoNormal><span lang=3DEN-US>Best regards,<o:p></o:p></span></p><p cl=
ass=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DM=
soNormal><a href=3D"http://www.orange.com/"><span style=3D'font-size:12.0pt=
;font-family:"Times New Roman","serif";color:blue;mso-fareast-language:FR;t=
ext-decoration:none'><img border=3D0 width=3D40 height=3D40 id=3D"Image_x00=
20_1" src=3D"cid:image003.png@01D5C7C7.D7BCC670" alt=3D"Logo Orange"></span=
></a><span style=3D'font-size:12.0pt;font-family:"Times New Roman","serif";=
mso-fareast-language:FR'><o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'line-height:15.0pt'><span style=3D'font-size:12.0pt;font-family:"Times =
New Roman","serif";mso-fareast-language:FR'>&nbsp;<o:p></o:p></span></p><p =
class=3DMsoNormal><b><span style=3D'font-size:10.0pt;font-family:"Arial","s=
ans-serif";color:black;mso-fareast-language:FR'>Samir Abed </span></b><span=
 style=3D'font-size:12.0pt;font-family:"Times New Roman","serif";mso-fareas=
t-language:FR'><br></span><span style=3D'font-size:10.0pt;font-family:"Aria=
l","sans-serif";color:black;mso-fareast-language:FR'>Expert en ing=E9nierie=
 de l&#8217;exploitation </span><span style=3D'font-size:12.0pt;font-family=
:"Times New Roman","serif";mso-fareast-language:FR'><br></span><span style=
=3D'font-size:10.0pt;font-family:"Arial","sans-serif";color:black;mso-farea=
st-language:FR'>ORANGE/OF/DTSI/DERS/DR/DRM/RMC/ETI </span><span style=3D'fo=
nt-size:12.0pt;font-family:"Times New Roman","serif";mso-fareast-language:F=
R'><o:p></o:p></span></p><p class=3DMsoNormal style=3D'line-height:15.0pt'>=
<span style=3D'font-size:12.0pt;font-family:"Times New Roman","serif";mso-f=
areast-language:FR'>&nbsp;<o:p></o:p></span></p><p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Arial","sans-serif";color:black;mso-=
fareast-language:FR'>Fixe : <a href=3D"https://monsi.sso.francetelecom.fr/i=
ndex.asp?target=3Dhttp%3A%2F%2Fclicvoice.sso.francetelecom.fr%2FClicvoiceV2=
%2FToolBar.do%3Faction%3Ddefault%26rootservice%3DSIGNATURE%26to%3D+33%204%2=
037%2045%2060%2066"><span style=3D'color:black;text-decoration:none'>+33 4 =
37 45 60 66 </span></a></span><span style=3D'font-size:12.0pt;font-family:"=
Times New Roman","serif";mso-fareast-language:FR'><br></span><span style=3D=
'font-size:10.0pt;font-family:"Arial","sans-serif";color:black;mso-fareast-=
language:FR'>Mobile : <a href=3D"https://monsi.sso.francetelecom.fr/index.a=
sp?target=3Dhttp%3A%2F%2Fclicvoice.sso.francetelecom.fr%2FClicvoiceV2%2FToo=
lBar.do%3Faction%3Ddefault%26rootservice%3DSIGNATURE%26to%3D+33%206%2043%20=
61%2039%2030"><span style=3D'color:black;text-decoration:none'>+33 6 43 61 =
39 30 </span></a></span><span style=3D'font-size:12.0pt;font-family:"Times =
New Roman","serif";mso-fareast-language:FR'><br><a href=3D"mailto:samir.abe=
d@orange.com"><span style=3D'font-size:10.0pt;font-family:"Arial","sans-ser=
if";color:#FF6600;text-decoration:none'>samir.abed@orange.com</span></a><o:=
p></o:p></span></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p></div><PRE>___=
___________________________________________________________________________=
___________________________________________

Ce message et ses pieces jointes peuvent contenir des informations confiden=
tielles ou privilegiees et ne doivent donc
pas etre diffuses, exploites ou copies sans autorisation. Si vous avez recu=
 ce message par erreur, veuillez le signaler
a l'expediteur et le detruire ainsi que les pieces jointes. Les messages el=
ectroniques etant susceptibles d'alteration,
Orange decline toute responsabilite si ce message a ete altere, deforme ou =
falsifie. Merci.

This message and its attachments may contain confidential or privileged inf=
ormation that may be protected by law;
they should not be distributed, used or copied without authorisation.
If you have received this email in error, please notify the sender and dele=
te this message and its attachments.
As emails may be altered, Orange is not liable for messages that have been =
modified, changed or falsified.
Thank you.
</PRE></body></html>=

------=_NextPart_001_0095_01D5C7CF.15C9C4C0--

------=_NextPart_000_0094_01D5C7CF.15C99DB0
Content-Type: image/png;
	name="image003.png"
Content-Transfer-Encoding: base64
Content-ID: <image003.png@01D5C7C7.D7BCC670>

iVBORw0KGgoAAAANSUhEUgAAACgAAAAoCAIAAAADnC86AAAACXBIWXMAAC4jAAAuIwF4pT92AAAA
B3RJTUUH4gsaDS4pnkGU0AAAAERJREFUWMPt2LEJACEQBMA7sWm/ANvWBgQT4UFnw00m2GxztPgl
JQIMBoPBYDAYDAaDwZvURdfHeedLGz8Hp0cAfB08AREtBUFTDB0HAAAAAElFTkSuQmCC

------=_NextPart_000_0094_01D5C7CF.15C99DB0--

--===============1373509630==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--===============1373509630==--
