Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D81C02198
	for <cocci@archiver.kernel.org>; Mon, 10 Feb 2025 11:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:message-id:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=9LUAtDC3UiUG4BOuaHqfvDZAkNxpXPfnxXJeOn5Ss+o=;
  b=qDtR40VjKmDcAndmTUSTmegxRkFdlkWJaPieStaGyuUNrYR7t1YgVdY3
   Xx1QaiDEs12MU5vxH05VuSYLbwCg8CjgkRzBK5Ti7Hn/AlImrqV5pRLHr
   Ro2FbuIhiTOexICRe9YjTE8qcn0Bi963s/nstGfI0mCFExCuJ3+dLxf1T
   M=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.13,274,1732575600"; 
   d="scan'208,217";a="207460939"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Feb 2025 12:08:10 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5A5DDE0D1D; Mon, 10 Feb 2025 12:08:10 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 6C292E0260
	for <cocci@sympa.inria.fr>; Mon, 10 Feb 2025 12:08:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:message-id:subject:mime-version;
  bh=9LUAtDC3UiUG4BOuaHqfvDZAkNxpXPfnxXJeOn5Ss+o=;
  b=Bz8jaqDNL4ZhrGPKRPpFvnNIKv7PTfdn2C6HSvIJDkHz80LQLJ2jbCJn
   o2bCYS+GseS+QnM7pHQlGo9IUIrOZ56epeqHf45oSnacRmEG7E6GCw7NV
   ES+95rZqbX1XDBvrJ72HhF44LVH8KrSL0H0e3lRU+5Fef2P4liU1UvFjC
   s=;
X-IronPort-AV: E=Sophos;i="6.13,274,1732575600"; 
   d="scan'208,217";a="207460923"
X-MGA-submission: =?us-ascii?q?MDHIjYk1AkzuwgS5uaq+usSntOaTbrppZraNaE?=
 =?us-ascii?q?gisDL4fej2QKLq9sJnVIZt1zTo5uoiTNIut9jPqqB/1d9R4ua4waWrq8?=
 =?us-ascii?q?IW56i7rF4LMGeDFjlg70MAaZq1tXEc/fSxHK9c7r8zj8dUMNxkBODBju?=
 =?us-ascii?q?haAoGDWc4gTij22OfvHAAnAA=3D=3D?=
Received: from zcs2-store8.inria.fr ([128.93.142.6])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Feb 2025 12:08:05 +0100
Date: Mon, 10 Feb 2025 12:08:05 +0100 (CET)
From: Fonyuy-Asheri Caleb <fonyuy-asheri.caleb@inria.fr>
To: cocci@inria.fr
Message-ID: <1579016749.8625707.1739185685318.JavaMail.zimbra@inria.fr>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="=_5206cb97-3262-45f3-addb-4f0a10b18819"
X-Originating-IP: [131.254.23.3]
X-Mailer: Zimbra 10.1.5_GA_4724 (ZimbraWebClient - GC131 (Linux)/10.1.5_GA_4734)
Thread-Index: SPP0Cbkz1+hz673J95O6w9hauiqlCw==
Thread-Topic: Creating function definitions from function pointers in a struct with coccinelle
Subject: [cocci] Creating function definitions from function pointers in a
 struct with coccinelle
Reply-To: Fonyuy-Asheri Caleb <fonyuy-asheri.caleb@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2387
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/1579016749.8625707.1739185685318.JavaMail.zimbra%40inria.fr>

--=_5206cb97-3262-45f3-addb-4f0a10b18819
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello, 

I am new to coccinelle and am interested in creating a patch which can define functions based on the function pointers 
available in a struct declaration. Since the names of the pointers don't exactly match the 
function definitions I want, I used a python script to modify the names. Below is my script: 

@m_rule@ 
field list f_list; 
identifier I; 
@@ 
struct I { 
f_list 
}; 

@script:python p_rule@ 
nf << m_rule.f_list; 
n_list; 
@@ 
new_nf = [] 
for f in nf: 
parts = f.split("(") 
r_type = parts[0] 
if '*' in r_type: 
r_type=r_type.strip() 
else: 
r_type = r_type.lstrip() 
f_name = parts[1].split(")")[0].replace("*", "").strip() 
params = parts[2].split(")")[0] 
new_nf.append(r_type + "pv_" + f_name + "(" + params + ")") 
new_nf.append(r_type + "hvm_" + f_name + "(" + params + ")") 


Please how can I write a new rule that defines several lines of function definitions from 
the p_rule new_nf list available in my python structure? 

I tried adding the list in a plus(+) entry but that does not work. 


Thank you in advance for your help. 

Caleb 

--=_5206cb97-3262-45f3-addb-4f0a10b18819
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div>Hello,</div><div><br data-mce-bogus=3D"1"><=
/div><div>I am new to coccinelle and am interested in creating a patch whic=
h can define functions based on the function pointers&nbsp;</div><div>avail=
able in a struct declaration. Since the names of the pointers don't exactly=
 match the&nbsp;</div><div>function definitions I want, I used a python scr=
ipt to modify the names. Below is my script:&nbsp;</div><div><br data-mce-b=
ogus=3D"1"></div><div><div>@m_rule@</div><div>field list f_list;</div><div>=
identifier I;</div><div>@@</div><div>struct I {</div><div>&nbsp; &nbsp; f_l=
ist</div><div>};</div><div><br></div><div>@script:python p_rule@</div><div>=
nf &lt;&lt; m_rule.f_list;</div><div>n_list;</div><div>@@</div><div>new_nf =
=3D []</div><div>for f in nf:</div><div>&nbsp; &nbsp; parts =3D f.split("("=
)</div><div>&nbsp; &nbsp; r_type =3D parts[0]</div><div>&nbsp; &nbsp; if '*=
' in r_type:</div><div>&nbsp; &nbsp; &nbsp; &nbsp; r_type=3Dr_type.strip()<=
/div><div>&nbsp; &nbsp; else:</div><div>&nbsp; &nbsp; &nbsp; &nbsp; r_type =
=3D r_type.lstrip()</div><div>&nbsp; &nbsp; f_name =3D parts[1].split(")")[=
0].replace("*", "").strip()</div><div>&nbsp; &nbsp; params =3D parts[2].spl=
it(")")[0]</div><div>&nbsp; &nbsp; new_nf.append(r_type + "pv_" + f_name + =
"(" + params + ")")</div><div>&nbsp; &nbsp; new_nf.append(r_type + "hvm_" +=
 f_name + "(" + params + ")")</div></div><div><br data-mce-bogus=3D"1"></di=
v><div><br></div><div>Please how can I write a new rule that defines severa=
l lines of function definitions from&nbsp;</div><div>the p_rule new_nf list=
 available in my python structure?&nbsp;</div><div><br data-mce-bogus=3D"1"=
></div><div>I tried adding the list in a plus(+) entry but that does not wo=
rk.&nbsp;</div><div><br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=
=3D"1"></div><div>Thank you in advance for your help.&nbsp;</div><div data-=
marker=3D"__SIG_PRE__"><div><br data-mce-bogus=3D"1"></div><div>Caleb</div>=
</div></div></body></html>
--=_5206cb97-3262-45f3-addb-4f0a10b18819--
