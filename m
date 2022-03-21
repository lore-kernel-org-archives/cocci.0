Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1173EC433EF
	for <cocci@archiver.kernel.org>; Mon, 21 Mar 2022 18:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ih1VlgnEoiuIUyYEImYiLGckMw2Qy6q9wkHXXVCGO3s=;
  b=fD4DSwZbOaGrJ5rjTYi5w8mY7MsU46bvGy4vKMinyD4nJh1yg9Qvb4FK
   lQ9GOkl+yslopIKdMObV2t5Vdck64XTGv5nEcfUCU+0rI2MQ1AuR6ida5
   5i15YC+VqgWcdlJRUt34a8nPUfQxj+UhTcj4ZN7XrNi04KPHkaCRiZcWK
   Q=;
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
X-IronPort-AV: E=Sophos;i="5.90,199,1643670000"; 
   d="scan'208";a="27303817"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Mar 2022 19:07:06 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 27D71E0219; Mon, 21 Mar 2022 19:07:06 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 9854DE0069
	for <cocci@sympa.inria.fr>; Mon, 21 Mar 2022 19:07:04 +0100 (CET)
IronPort-SDR: t2+IyGFPzjnTRAb/sbbJwr2sK7U43y/mUmT1zGpr+pkrgTHUop52q6RYa7GMJ5tLmi2t51pk0z
 ixlYkr08lC4tyiTDVJiF/qSB5A5B6XhMjqY2yjiljZ90I+d+nFFSIyZg30JWqD2YTr09NKTLa+
 fvRmN/18J9ZsQAl8e7tS67IJt3iSx3BT+M9pA/ZA4izQ7mvhHPAiA1rdeg1hmUYn42KurRjIVO
 iSJ+B+X1KVriQNLpQM6UqwyjSpAjTzQ4MTv40hLnbRlRuKfOkqQDIBUbwFb4Bb03wXelQuTtUD
 PqD/iTtZVBjb7DkhmfpQweBu
X-IPAS-Result: =?us-ascii?q?A0B0CAByvjhihwwR49RaHQEBAQEJARIBBQUBQIFaAoImg?=
 =?us-ascii?q?VUrBAtEhFSIKIZLhkeHBYcYiiiBewsBAwENEgErAQIEAQGFBwKEPAIdBwEEO?=
 =?us-ascii?q?AINAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBEwEBAQwNCQUICgcOE?=
 =?us-ascii?q?AU2Bl4GZASBSwSBdAs0DYI1IoNsAwMjHQEBESYBDwsODAImAgJXBg0IAQGDA?=
 =?us-ascii?q?IJlAQMyrV2BMYEBgggBAQaESB8sIlKBWwmBECwBjU56JxCBVUSBPIMDPoRFg?=
 =?us-ascii?q?xqCZa5OrXA0B4ISgTqBQQyeEQYULoNiklsOBpFtllunAoIPgWczGiSDOE4BA?=
 =?us-ascii?q?gECDQECAgMBAgECCQEBAo4dGYQMiixANDgCBgEKAQEDCYVHAQGMKQEB?=
IronPort-PHdr: A9a23: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
 X5jfkkLorDCtUuwbd1gFmYH4nc3dIG5
IronPort-Data: A9a23:5ugsQqmKOKEqoo6njESRsNzo5gyOIERdPkR7XQ2eYbSJt1+Wr1Gzt
 xIeCmnXP6uCNGGjL4p3OYqx9E8Au5WDz9JkTwI9riA8H1tH+JHPbTi7BhepbnnKdqUvb2o+s
 p5AMoGYRCwQZiWBzvt4GuG59RGQ7YnRGvykTres1hlZHWeIcg944f5Ys7N/09YAbeSRWVvX4
 4up+ZSHYjdJ5hYtWo4qw/LbwP9QlK+q0N8olgRWiSdj4TcyP1FMZH4uDfnZw0nQGuG4LcbmL
 wr394xVy0uCl/sb5nxJpZ6gGqECaua60QFjERO6UYD66vRJjnRaPqrWqJPwZG8P4whlkeydx
 /1q7ZGBViE7B5H9u8hCSQJ4CAR9MatvreqvzXiX6aR/zmXDdGbwhepjBgc6MOX0+M4tWDsIr
 6ZHbmlSKEnZ7w616OrTpu1Eo805L9Tweq4btGthyz7xEvssB5zOK0nPzYUHh29r1pgQdRrYT
 9YEVidgRxTsWj8Ra0UIMMwOtvmFh1CqJlW0r3rM+PZpujGNpOBr65DmN9Hee/SRVMBNlwCZo
 HjH9iL3GHkn2Me3zD2Y7jSzi+WJkS6TtJ8u+KOQ0aZnsUK11FUvOT46CkGggeKciUK4cocKQ
 6ALwRYGoa83/U2ta9DyWRykvXKJ1iLwvfIPSYXWDynSkMLpDxal6nssE2YdM4Z63CMibWN6j
 w/T9z/8LWE36NWopWShGqC8gR7a1cI9CGgEeSYORBYfizUIiNxt0kuXJjqPOJS1g9zzHTj2z
 3WyoiE6ld0uYSMj0qKm4RbYjjjqqpWhou8JCuf/DjLNAuBRPdDNi2mUBb7zs6wowGGxEADpg
 ZT8s5LChN3i9LnU/MB3fM0DHauy+9GOOyDGjFhkEvEJrmrxpC77LNsNsW0jei+F1/ronxe2M
 Cc/XisOtfdu0IeCNvEfj3+ZVph7k/O6fTgbfqqJN4AVCnSOSON31HgzORDJhj6FfLkEyO9mc
 Zadbcu2C3sGQa1opAdatM9NuYLHMhsWnDuJLbiil0rP+ePHOBa9FOlZWHPTMLFRxP7V+G39r
 ocEX+PXmkU3eLOlOEH/r9VMRW3m2FBgWPgaXeQMKrXcSuencUl9Y8LsLUQJINU0wf4Kyr+Wo
 hlQmCZwkTLCuJEOEi3SAlgLVV8ldc8XQasTMXN+MFC29WIkZIrzvq4Te4FpL6Yq/qpvwKcsH
 fUCfsyBBNVJSyjGomhMM8Oi8dY6LBn71xiTOyeFYSQke8AyTQL++ujiIlnl+h4IA3flrsA5u
 bChiljWTMNbFQRvBcrbcty1yFa1sSRPke5+RRWaPdRZPknhqdA4Jyv0h/4xAscNNRSammrEj
 VnLW09AqLCU8YEv8dTPiaSVlKuTErNzThhAAm3WzbeqLi2ErGCt9o93Vrradz7qUm6pqr6pY
 v9Yzq2nPfAKwARKvo57H+o5xK4y/YK29bpd0xgiA3jBKVimU+syLn6D1MhJl6tM2r4A5VroA
 B3SoIECNOXbIt7hHX4QOBEhMLaJ28YUrT+Ov/47F0P3uX1s972dXEQOZBSB1H5HIL1uPN93y
 OstopdPuQm4lwZsLduMyCxZrjzeInsFWqQhl5cbHI6y1lt1kA4fO8SEB3+k+oyLZvVNLlIuf
 G2eip3CsLIAlEDMRHw+SCrW1u1HiJVS4x1HwTfu/bhSdgYpWxP24PFQzdjzZgFS0wkBzO95f
 GRmX6GwyWNi4B8w7PWvnUj1c+2COPFd0lP8wR0FmQU1imG2A3fVIjRV1fmlpSgkHqE1QtSf1
 K6VwiDpXF4GuS03MjQaASZYlhAocTC9GsAuVixq8wRp0qTWuQbYv5I=
IronPort-HdrOrdr: A9a23:smK4W661nqggMtU42gPXwOzXdLJyesId70hD6qm+c20xTiXqrb
 HMoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhWotKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkbNDSaNzhHZKjBkWuF+poboeVu68qT9JzjJppWPHtXg5gL1XYFNu4Rf3cdeDV7
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,199,1643670000"; 
   d="scan'208";a="27303806"
X-MGA-submission: =?us-ascii?q?MDEqJtr6LgDja06wVt13cjSkpjvRiM4+PCttAd?=
 =?us-ascii?q?Od3dm5mt1p10k+twrOZdugOG46hwEkm2ilBQK1O+JmR0dRRC9Hdp2JOn?=
 =?us-ascii?q?Ymk8ftYhDoOA9UBrYKCfLvG9OT3X5LLwu/v+l9xwWkwVHVyM5lits+hs?=
 =?us-ascii?q?a4clz2sxxYa0+fWtJmb9bwBQ=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 19:07:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1647886023;
	bh=0KOE0sK+LYIeoycKGr5ayWjLrYo5axwkLHW4UhO0Yeg=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=lp6r633OlqxFLl/jT/UYVDYo4z0qXPpzs4rSb3Qx2aVRIVapH1eZmWLf76fjkVi3N
	 gDmaOMGIB/jIFist4FIpMyoeoS9j4NOJXSziosGuC6+v6xdmE+Eey7GO8HU80sfg7+
	 2htGDebF4JUit0qAI9SD0uEg7+xuYDJE9edY6Exk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.154.81]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N2SP7-1oDxuL4Bah-013jzd; Mon, 21
 Mar 2022 19:07:03 +0100
Message-ID: <d5840b8b-9ef0-b078-592d-d5a66cffb775@web.de>
Date: Mon, 21 Mar 2022 19:06:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-GB
To: Eric Wheeler <cocci@lists.ewheeler.net>
Cc: cocci@inria.fr
References: <a28111b-90ab-1d57-58de-113a50f61f41@ewheeler.net>
 <trinity-aa278557-9b21-4086-848b-218a903ce0ee-1647853331428@3c-app-webde-bap05>
 <6355cbc2-9bb1-3c72-43d3-a02e48df52e@ewheeler.net>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <6355cbc2-9bb1-3c72-43d3-a02e48df52e@ewheeler.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FzaOkRJXWm9UWyvpct/9hRCIrLRYDAjmjIwby7em4cbwlg25GIz
 OKyGB6utir0si1iJ4f65D5QFFp5OaNXvAfxQsjMQ+BtOByPvJv/g5p5D6QiieqffdAn97Wb
 7+4WN1qbJF7fooN5YMKnH6cPqcgQWccj+CDzNXh1EMLkDpKqrP2ikFZG4UsSapS+mynI0Jx
 q4bw1c7gLJtjE2zIAJ0gQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:02pQyQIPLUQ=:0gQ/xyMXyy+dI+lLu+9mmh
 8F9n5w2t/8kaa+sYomnCnfHq5KdkVgJcoo3hS9SomQSnAhl4OdWv19e9MEUsAtQnZjbDq8Y+z
 DXRrMZ72hvszWpSJUpUAoCVhqOQ/jjSo0ZQ8/QHGeG+ry5dW1IYqK7gvNmjZd9Sax7vYbGwZS
 sk3m7Wlyz+4vdJGT0AS2P1n+VmM3dp8enTcSexINk3XtNtPv6s7PFqqYYPV2xK9Td2PclmQdb
 PM5XeJUzPM8+HLKTvdj3xR4t1kyr9R2oMF6l/YcxPFwaRyHIDqKp7AWhbz4XIqGGBxNYrHi+D
 9MM9AfID3iuQAVjEgOcNY0Xr6MvQ0TOZ4EgdfzbxWcsEJRHhWkXKA3mfLWjcP7AgEqWZCKn2w
 OL5Ml737bHSUuscmJ8llwiGSY4mHOW1ZFNn837LJ31sHgtxAvGSkms9fm1+h4o9IILxgBWbmf
 rDNqnVqmk5Gb+zHdayoKbsNolGSVzA/OEPRSNdRie/BOop09euJDOcHns3IBVst20vFbxvDTs
 J7yz3Py20OvEW0uYA55ErKLkGrQ3uUW/jf4fnmh8q6Si69lrESfCbHaHh9R16/Qi4mG0oCcal
 qdY2N8x4kVoAVYAiRNYve05UlPUNPxfLTn4/gzyPtzaamjDy8wFo1AnZqhLlKZEXDiyUFUce0
 pHd12PXXP9uJuZuwrjmCPNPBIEW+uNQgoA1FQr2MPOGVvDLtBXdpszgvoKnuJRZ+Ml1ZhXOWU
 P0n1g7bLpxuwD4NXA1Vj51C5ZhQ8gWlRmInNzD/yVscn/8p9wLIdRk5u4z5E/2NYTPBtoshhF
 NBy/4MMf1utH3PzQcT8uE/CAYs7oQrfb2M0xvWsfm3wif8yCGL8kpF3eL302DvFWn8qclXxJa
 QSLNTpsd8YDxTmkSKiwJQIoZxxev4y+TNBxb3ut2tpjN7sMh6bt4m1EL6jihtYDTnYnbXIkP5
 PT+QZS2alx73D0C+C8HnrrbptuvQwgMo9ZTPYQWt11PhvsK4+RVKRUQtbNSiGpOtFFUFMF7Bm
 XnUj4PllLBxiMoqYVSDaj189SVKhjvZbn1fZwg14VYiVzJo2hngT3zdD90wUsluwMeirrZVD+
 dwGYXPSG6f6+Tk=
Subject: Re: [cocci] Is there a stringify operator?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 276
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/d5840b8b-9ef0-b078-592d-d5a66cffb775%40web.de>

>>> 	@ r2 @
>>> 	type r1.T;
>>> 	identifier r1.I;
>>> 	@@
>>> 	++printf(#I " has a datatype of " #T "\n");
>> Do you need any extra debug information?
>>
>> Are you looking for further advices so that more source code transforma=
tion
>> alternatives will become interesting?
> What do you mean?


I assume that the shown print statements (besides the usage of the macro =
=E2=80=9CSTRINGIFY=E2=80=9D)
are connected with special data processing requirements which can eventual=
ly
be handled better with advanced SmPL scripts.

Regards,
Markus
