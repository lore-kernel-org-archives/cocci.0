Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7860C433FE
	for <cocci@archiver.kernel.org>; Wed,  2 Nov 2022 19:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=XKctoVXK16Dte4uJuhh+XcwWjyw4w7bYl0Xmg+XrwkU=;
  b=J6ElMzT9RLjUuIbYd6Ytbwg/jfIRzzJcZJgGgFUgUdz2c1P40foZXV6k
   390Pg+ZrVwi/TlhI9sERNTJJL1RMXiSLf6O9XWUZ32xI4RTsW8euGVtQu
   2kuwrf7HY20+tQyE5YLERZwlKu0xVS0gc1e7t+jntqkZ4qNXX/aVTIr6V
   I=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.95,234,1661810400"; 
   d="scan'208";a="72713039"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Nov 2022 20:15:42 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A34DEE0154; Wed,  2 Nov 2022 20:15:42 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 70D1BE002A
	for <cocci@sympa.inria.fr>; Wed,  2 Nov 2022 20:15:41 +0100 (CET)
IronPort-SDR: 6362c1dd_L86RCPCdWOw4U3Sfb8bbw1PQJCXnBUGklXNgU0Ptu8JKDhm
 sGaJZuN/AY6vk/3infJkQy9GEYo/E9Q3E8m87pQ==
X-IPAS-Result: =?us-ascii?q?A0AnBQAYwWJjh07ASNlaHgEBCxIMQIN8gQRTLgQLRYROj?=
 =?us-ascii?q?nWCKIQohxyHLYwyDwEDAQ1BAQIEAQGFBQKEeQIdBwEENBMBAgQBAQEBAwIDA?=
 =?us-ascii?q?QEBAQEBAwEBBQEBAQIBAQIEBAETAQEBFwsXBw4QBSKFaA2CNSkBg2QBAgIBI?=
 =?us-ascii?q?x0BAREmAQQLCxoCJgICVwYNCAEBgnmCbQEDDSMHrRiBMoEBgggBAQaYEh8sI?=
 =?us-ascii?q?lOBXQmBESyMUoQnJxCBVUSBPIMDPoREg1eCZo8Fh1smBA4DGSsdQAIBCzsyD?=
 =?us-ascii?q?UsbMScOCR8cCgQXDQUGEgMgbgUKNw8oL2crHBsHgQwqKBUDBAQDAgYTAyICD?=
 =?us-ascii?q?SkxFAQpEw0rByNxCQIDImUFAwMEKCwDCSEfBxYRJDwHVzoBBAMCECI6BgMJA?=
 =?us-ascii?q?wIiWHQCLxEVBQMNFyUIBU8ECDoCBQZSEgIKEQMSDwYmSA5KPjkWBidEATQPD?=
 =?us-ascii?q?hYDYIFwBpxQW4Ekwkc0B4IegUyBTAyeYgYTLpZsDgaSE5ctp3eBeSOBWzMaJ?=
 =?us-ascii?q?IM2TwMZD44gGYQMiixANDsCBwEKAQEDCYVHAQGEdQEB?=
IronPort-PHdr: A9a23:SniddR0QAUO+8VcIsmDOkQ4yDhhOgF0UFjAc5pdvsb9SaKPrp82kY
 BaDo6wyxwaTBc2bs6sC17CN9fi4GCQp2tWoiDg6aptCVhsI2409vjcLJ4q7M3D9N+PgdCcgH
 c5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFRrhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTajbr5+N
 gi6oAfeusULn4duNrs6xh/VrndVYehbyn1kKFyJkxrg+su8+YNo/jhNtf4m68NOS7jxcb4iT
 bxfAjQmMmQ169PuuBLeUwaB5WYSX3sPnBZQDAfL8B/1XpHqsivnreV9wzWVPdf3Tb8vRzuv6
 bpgRQLyhycGMz4593zXitB1galGrh+tuwBzzojJa4yOKvFwYr3Scs8bRWpZX8ZeSSpBAp+nb
 4ASC+YNJPtUo5Xhq1cLqxa1GAuiC/71yjJQhXH406I13Oo8Hw/Y0gwtAdIAv3bIo9v6L6oST
 fm1wbPUwTnfYf5b2zHw45XIfBA7pvGMWKp9f83Lxkk1FAPFk06QopHqMTOR2OQNqWmb7+xvV
 emyjGMprBt+oiKsxscxkYnFnI0bylTK9SVjwYY1I9K4RVV1YNG6C5RcrTyVOJVvT84kXmpnt
 zo0xKcctp6nYCgF1o4nxxjHZvGHfYWF/xztWemMLDpmi3xrd6yyiRix/EauxeDxV8253VZEo
 ydYkNTBtm0A2h7O58SbV/Zw/0Ss1CuP2g3N9+1JJ10/m6nDK5M53LI8i5gevV7BEyPogkn6k
 aubels+9uWq6OnrerHrq5CGO4J6lw3yKKcjltGlDeglMwUCQ26W8vmm2rL55032WrBKg+U2k
 qbHtJDaItwWpqu+Aw9IzoYv8Ri+ACm939gCgHYIMkpJeBOBj4f3J1HDOO70Aeq9jli2kjpn2
 erKMqDlD5nTNHTOkrTsca5460FGyQozyd5f54hTCrEEOP/9XVX+tMbbDh8kKAy42enpCNFz1
 oMEWGKPBKCZPbjcsFCW/e0jOfSDa5ENtDb7MPcq/+TugmMhmV8BYamp2oMaZG2gEvR8P0qZe
 WbsgssGEWoSogU+S/Dlh0GDUTNIfHazX6c85ikhB468DIfDQJqtgL2b0yuhEJ1WfDMONlfZK
 nrifp6YWv4Kb2q3I8ZnlXRQULmoTYg62BunrxP7wrxgBuXR8ywc85nk0Y4myffUkEQX/CZ3E
 t/V/mWDVWBykStcYjYs371k52F5xE2C16dQnPFSU9BesaAaGjwmPILRmrQpQ+v5XRjMK5LQE
 A7OqrSOBDgwSoh02NoSewNnHN7kiBnf3i2sCrtTlrqRBZVy/LiPl2PpKZNbzHDLnLIkk0FgW
 tFGYEivnK1i7E7+A4DTkkOWv7mnf+IQ0X2F73+NmFKHp1oQSwtsSePAVHEbaFHRqIHc71nBU
 qToJLApKApHxuadJ6EMZtC6xU5eSqLFP9LTK3m0h3/2BRuMweaUa5H2fmwGwCjHIE0DjhxV4
 nuMcwQzbsu4i0TZCjEmVVfmYke2tPJ7tGv+VEg/iQeDc0xm0bOxvB8Tn/2VDf0JjPoCv286p
 jN4EUzYvZqeAsecpwdnYKRXYM8sqFZB22XDsgVhP5umZ6l8j18aeg5zsgvgzRJyQolHlMErq
 jstwm8QYeq92UlCaije8JT+ILzRJUHt8RrpZ6OXklDS3dCK+7sevewiogartwWoG0w+tnR/h
 oMMjD3DvNOTXVBUDsKiNyR/vwJ3rLzbfCQnsobd1Hk2dLKxrieHwdUiQu0s1hened5bdqKCD
 g77VcMAVK3MYKQnnUakahUcMaVc7qkxaomDfuGFxbXtEeJuhjOggkxY7Yo73k/GpE8eAqbYm
 o0Ixf2VxF7Ncj7mj0q69O3zl5pFYz46AWe1jyTpTt00BOU6bcMADmGgJNeyz9N1isv2WnJWw
 1WkAksPxM6jfRf6g0XV5QRLzgxXpHWmnXH91Dloi3QzqaHZ2iXSwuPkfR5BO2hRRWAkg02+a
 YSzitkbWgCvYW1L3FOA7Fz52rMdiaBxNWjVTm9XciKwI2wqXqart7WEatJC89ty6HoRD776O
 AHADOGt6xIBmzvuBW5f2Cw2e1TI8t3ikhp2hXjcZHd/oXzFeN1hkBLW5djSX/lUjXINQCh1j
 yWSB0DpZYD2u4rO0c6S6KbhBzHENNUbayTgwIKeuTHu4GRrBUf6hPWvgpj9FgN81ybn1t5sX
 CGOrRDmY4Ct2b7pVIAvNkRuGlL47NJ3X49klY5lzrQZw3sHndO4+XQdkGH8GcpW0+TyYTBeI
 FxDi86Q+wXj1EB5eziszpj6S27b789vfdi8bUsJ1yh7480AW8L2pPRU2CBypFS/twfYZ/Nwy
 ywcxfUZ43kfm+gVuQApw3bVEvUIEEJfJyCpiwWQ4oX0svBMfGj2O+vVtgI2jZW7AbqFuA0ZR
 HvpZsJoA3pr9ssmeFPUjC+ps9uiIoOPK4tJ6FvNyUeH1bUwStp5l+JW13A+YySn5yJjkrN91
 Vs0gNm7pNTVcTw3uvjjXVgBaXutIJlMsjD10fQEx5nQgNrpR8Q7XG9XDNyyHJfKWHoTrai1Z
 1zISWNh7C7GSPyHWlXBoEZ+8yCVSs/taCvRfiFGi40lHkbVJVQD0lpNA3NlxNhgR1rsmpCmK
 hkchHhZ50ak+EsWjLs2al+lCDaZ/VzwIjYsFMrPdlwPsFwEvRyNd5bEpqd6GyUSlnG4hCqKL
 GHTJwFBDGVTH1eBG0imJL6lo9/J7+mfAOO6afrIe7SH7+JEBb+Owtq0341q8izpVI3HN2R+D
 /A9xktIXGxoU8XflTIVTiULliXLJ8eFrRa48ydzo4ix6vPuEA7o4IKODfNVP7ANs1iuhryfM
 ueLmCtjATNfy49K2nLCjrQSnRYThyxoazixAOEAuCrKH8ey0udcCx8WbT82NdMdtftjmFYXf
 5eK0JWqhu0d7LZ9EVpOWF3/l9v8YMULJzv4L1bbHAORM7/AIzTXwsbxaKf6SLtKjewSuQfj3
 FTTW0LlIDmHkCHkEh61NuQZxgSSJh9Do8eQdhh3CG7sZM3rYFu3PZUk6F9+ia1xnX7MOWMGZ
 HJkdFhRq7SL8S5CqvB4BnAH8Xdva+WJ0XX8jaGQOtMdtv1lBT5xnuRR7SEhyrdb2ypDQeR8h
 CrYqtMGS7COl+6S1nx4XRAIpjsZ3OpjWG19NK+f+pQSAR4sEzoS4G/WBxlY/rNY
IronPort-Data: A9a23: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
 t0AgKvOxBgRhQh5TCg=
IronPort-HdrOrdr: A9a23:yesosq0taJmXHV8nSNslDgqjBGYkLtp133Aq2lEZdPWaSL39qy
 ncpoV56faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SOzUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyUMbEQt6bHCWeDYrQd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.95,234,1661810400"; 
   d="scan'208";a="72713038"
X-MGA-submission: =?us-ascii?q?MDEiCAyEfVkymgtSz3feq+Tp0CCLnROkypKSp/?=
 =?us-ascii?q?zbFs9HVg/fAMe6yH8uBBjGV84yyMiJGbtzXDn2SMjcWISaavGdFusWXJ?=
 =?us-ascii?q?uryfatFaHbrHuTEcMJtFdWq77SBrfG5Ww4H9s4OscT8I/HtjQ9/bt0AP?=
 =?us-ascii?q?+5QrJJELLu1sE6VqwV5vXWMg=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 20:15:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1667416539; bh=XKctoVXK16Dte4uJuhh+XcwWjyw4w7bYl0Xmg+XrwkU=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
	b=hSl5aeqGFuL/Is/drwyB0Rx7120fvXujreh7e6FZ2oVpCLrbV/YNriBnJzGGdH0uK
	 kOejfbukg8dZ6HoJC2FHhPLQF29m8g+b0bFMTFCLxo52kPwrqAcHcQXiNwJQxqeoa9
	 jh4v4GGckmp7v0xIicWHIkETjOjujkWv9ALU1VR2elwZLvc7sPzCGrz4LcAbTsWbuY
	 bo5gUHLMLyxKEGQ/zGjruCDNvIfZEAZ7Xu2m+eXn0mJAiLnamQ+dI2MLnP/FehEKcQ
	 8oZiVDjrzbmBfI8VdLhpxD4ytZlhfH0ghmzTRKT/04f9wciwLq2eb1JSZMjOTnXpj+
	 P0LawT07N+Q9Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.160]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N3Xjd-1oyf602jDP-010Xa8; Wed, 02
 Nov 2022 20:15:39 +0100
Message-ID: <1b150ca0-402b-9b1a-7a47-da1a118d61d7@web.de>
Date: Wed, 2 Nov 2022 20:15:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Content-Language: en-GB
To: Sebastiano Miano <mianosebastiano@gmail.com>
References: <CAMENy5qK-KB1_D-zgh=UyLarKVaup-J0yRdZwTL-fkyn_gQhJg@mail.gmail.com>
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAMENy5qK-KB1_D-zgh=UyLarKVaup-J0yRdZwTL-fkyn_gQhJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/9WW8X5/hnCbE9kBdEyZxMLzKOOwd2OdNmZRxTnzqn46br9m3De
 TQijLMN60B27txojAZhNTMwNviB4BCoOoqItr2XmgqQekZxEIVFRfUBGctXJewnVlEJCyrY
 5z8bRHgLvQllV4bUU5MJ2wYOQ+7o68YPKW0IUDPdLk8mb30gCM7QLljgLi3zqrnkCQR+BAX
 iblhJjBJxAUbBImVADFYQ==
UI-OutboundReport: notjunk:1;M01:P0:f8gLgphNX90=;MlYx177RpYeisy38SAmLzSD8z8a
 TVCGmI5RtNnB7THeUkW1EKSt2UhF1XCqKESgNyrSxf9N1lzgpO4DV/ZGbYGsrX+G/8R9vSZIq
 rrUO6LDA5/Nla+BEaVe3S6QPj9eAKi5yUjSvJeb6OJn+U2heXY4SbsO35ykAJUFFqWXjs2frX
 mC/akm8J2ZR4hLyDqB329MLjYo77twdg0z1EXKQNHU5vURlXg4yqDGWNa0a1RnZDjGLrI9nZp
 92W/SbRNhBor9zpQe8rDVKz73TuzGRXylQjaMCVulg8tXCHZHypo3XyiyeKmdNeLxMluiDMo8
 RUGd2SX4ZQ+WKw09AVetYs+wJa66JVda1GOpNJydjDtGCd3b/JT3sTS9JkwfRlR8IYu/a8hNY
 ufXCzXkURClrmjz/16KtrORq2jFEhjDRT9AOIF9A9KlAehfoPu2hatPieUjH0bKjTtcMjYzIV
 YoY/EqirVVicurg6P0zIfuv7QE+syj4GSOnKtZqacoSjskDO0drzcNM9gAu7dG6klTU6jDawm
 EsykGu5BcVI/DcVhdWmSjR5s4jecx3b6kd7V+/9+zm0DGqIjp+G7CS13Uk5hjxdu5gwrbTXkS
 /W6yVMnBvVq9Qe8fQNE8JWI7KjPJANztHm7Twq4rdoaIwxVMk3+PSNnXHgXA096CsaBoQX3Eu
 GDIULHDtn0lIINTBMnIr9WgaLJzvXluommY8oUb/sgUqPkbJlGP73tKNVrH+86St/waJ0yTQg
 AuOECj41wQwbyEP4lGkKFVIBKWJ8rUZGrEVAvmwIPqXekXNztLJh6aF0kb5eq+sbaGV5thTc3
 Cat6cMigl7+CL7u8S59MqZcojUxNL6D//FFu4cHFOzx4zWjI1dIaxMFgTWAXySs1KxWNBFbLj
 IfCtzZr3FeJs8Kkp6kV5j5YwB7Dzi56YLK0HhYHpsloBznW0OLVafyJZaRRGdzr3ZEzIQuiR4
 rKoV4Q==
Subject: Re: [cocci] Replace custom function multiple times
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 701
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-11/1b150ca0-402b-9b1a-7a47-da1a118d61d7%40web.de>


> Any ideas on how to solve this issue?


How do you think about to use the following SmPL rule variants instead?

@initialize:python@
@@
import os

@searching@
expression path, fn;
@@
=C2=A0MERGE_FUNCTION_OPENED(path, fn, ...);

@script:python generation@
path << searching.path;
fn << searching.fn;
new_fn;
include_name;
@@
coccinelle.new_fn =3D cocci.make_expr(fn.strip('\"'))
pre, ext =3D os.path.splitext(path.strip('\"'))
coccinelle.include_name =3D cocci.make_ident("\n#include \"%s.h\"" % (pre)=
)

@replacement@
expression searching.path, searching.fn, generation.new_fn;
@@
-MERGE_FUNCTION_OPENED
+new_fn
=C2=A0(
- path, fn,
=C2=A0 ...
=C2=A0);

@addition depends on replacement@
identifier generation.include_name;
@@
=C2=A0#include <...>
+include_name


Would you like to reconsider also the implementation detail that an =E2=80=
=9Cidentifier=E2=80=9D
is used for the construction of a preprocessor directive so far?

Regards,
Markus

