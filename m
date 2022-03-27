Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20659C433EF
	for <cocci@archiver.kernel.org>; Sun, 27 Mar 2022 11:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Ek5yiysvkH4JZanO3APOUltvqOKvgd9tXMX4TekVvEg=;
  b=Oajwql2OTYwKyITqLY+yZbF+l2+x+UlxdLLptQ6zJfrKDw+mMbm8wjAM
   sSQ8DxN3GS0gCt7Zc1Mejl0r/EJjwpaMT+ZeYfJNYxa6qTHvDbmD1Xf9N
   dm33tjKdWnS1baYHcBjm7GUsE8Es9vVLKo+jWJ0dqOur6CJmreLwtH1GC
   U=;
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
X-IronPort-AV: E=Sophos;i="5.90,215,1643670000"; 
   d="scan'208";a="28495097"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Mar 2022 13:31:47 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id F1086E4372; Sun, 27 Mar 2022 13:31:46 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id AA26BE436E
	for <cocci@sympa.inria.fr>; Sun, 27 Mar 2022 13:31:42 +0200 (CEST)
IronPort-SDR: DbO96y3wsubPmaLNp/U6pym3n4ur97JPKi+DZZJavk0bkHz/i0Wy2DcaU62+JW42IrL2zGWkN0
 4QcUqVhtYbZNNO28nDk4LSYPBVIYO5vOm4PFRR8x6Zbv5p2mivBC88R6uZj9L2I/1Ydqmonoqq
 gKgOn8kYxQ5wgONdMesb0DtrwkMJfks2eTiroIQuH19g7lRzYLT3Koa6SoSv2aW6cbJto8bIQJ
 0H8jT0zCKQqVHNOIJdBwkqE61jX20j9ChMF5dC3LEiShkKu88UN/yu8NLinKCK677MIrs4KOyS
 FvxGaJobWvTMGb8vFl+XzWwi
X-IPAS-Result: =?us-ascii?q?A0BlAQBoSkBihwsR49RaHQEBAQEJARIBBQUBQIFagiiBV?=
 =?us-ascii?q?SsEC0SEVI5zgiiLJIcZjCMLAQMBDUABAgQBAYISgmsKAoROAh0HAQQ0EwECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEARMBAQEMDQkFCAoHDhAFNgZeB?=
 =?us-ascii?q?mQEgUsEgXQLNA2CNSkBg2QBAgIBIx0BAREmAQQLCxoCJgICVwYNCAEBgwCCZ?=
 =?us-ascii?q?QEDDSWuGoExgQGCCAEBBoRIHywiUoFcCYEQLI1QeicQgVVEgTwMgkcwPoRFg?=
 =?us-ascii?q?xqCZZlVE5UrrXU0B4ISgTqBQQyeEQYULoNikmEOBpFvllynBIF4gX4zGiSDO?=
 =?us-ascii?q?E4BAgECDQECAgMBAgECCQEBAo4dGYQMii0/NDgCBgEKAQEDCYVHAQGMFwEB?=
IronPort-PHdr: A9a23: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
 J7DmfCrQAo=
IronPort-Data: A9a23:IesyKqnZ8imu/tura6t5ztzo5gyvIERdPkR7XQ2eYbSJt1+Wr1Gzt
 xIXXGqCafjfNDf9Ltp/Ooq/8h8GvsWAxoQ1T1Nuryg8RltH+JHPbTi7BhepbnnKdqUvb2o+s
 p5AMoGYRCwQZiWBzvt4GuG59RGQ7YnRGvykTres1hlZHWeIcg944f5Ys7N/09YAbeSRWVvX4
 4up+ZKHYTdJ5hYtWo4qw/LbwP9QlK+q0N8olgRWiSdj4TcyP1FMZH4uDfnZw0nQGuG4LcbmL
 wr394xVy0uCl/sb5nxJpZ6gGqECaua60QFjERO6UYD66vRJjnRaPqrWqJPwZG8P4whlkeydx
 /1ErMecbgRwLJHK2+cCDDMIGTN5OYhJreqvzXiX6aR/zmXDdGbwhepjBgc6MOX0+M4tWDsIr
 6ZHbmlSKEna7w616OrTpu1Eo805L9Tweq4btGthyz7xEvssB5zOK0nPzYUIgGZt3pEQdRrYT
 8cyagFlQi3hXxkMK3RLVIBuhbf21naqJlW0r3rM+PZpujGNpOBr65DmN9Hee/SRVMBNlwCZo
 HjH9iL3GHkyMNWAwD6B2mCtg+XVlGX6XpgTHfu27JZXbEa7w2sOFFsJWFH9rfTRZlOCt8x3I
 lVP1g0t9LoO8g+oUYbXDxeqp3qhsUtJMzZPKNES5AaIw6vSxg+WAGkYUzJMAODKUudpH1TGM
 XfWxrvU6SxTXK69FCrBre3Ixd+mEXdFdD9YDcMRZVFdu7HeTJcPYgXnYvsL/ESdq9rzBTj6y
 i2QxMTVr+hN0ZdTv0lX1WrHjjOqopHPQksN6AzTTAqYAu5RYYm4e8q35FKd4fsowGelorup7
 CZsdyu2tb5m4XSxeMqlHr9l8FaBua/tDdEkqQQzd6TNDhz0k5JZQahe4StlOGBiOdsedDnib
 Sf74F0NtMQKbSfyNfIoOupd7vjGK4C/RbwJsdiLP7JzjmRZL1TvENxGOBLBgTu3+KTSuftjZ
 8zGGSpTMZrqIf06kGTvHrl1PU4Dn25njWLVWZ3hyRm7mbORDEN5up9VWGZimtsRtfveyC2Mq
 4g3H5LTl313DbOiCgGKr997BQ1bdRATWMGtw+QKJ77rClQ+RQkJVaWNqZt/INYNt/oOyY/1E
 oSVARIwJKzX3ieWcW1nqxlLNNvSYHqIhS9iZXV3ZwfxgRDOo++Htc8iSnf+RpF/nMQL8BK+Z
 6BtlxyoDqsdRzLZ1S4aaJWh/oVueA711x2DNWypbWFnLZJnQgXI/P7ifxfurXVfUHDo6JFm+
 7DwhBnGRZcjRhh5CJiEYvyYz2S34SoXltV0UhaaOdJUYkjtrNNnJnWp3P86Ks0BMzvZwT6e2
 1rECBsUv7efvII/ttXE3PjWo4CsGup4P0xbA2iCsefob3aHpDL7zNYZAuiSfD3bWGflw4mYZ
 L1Yn6PmLfkKvFdWqI4iQbxl+qIJ4Ye9rbFtyAk5Tm7AaE6mC+87L3SLgZtPu6lKyuMLsAe6Q
 BvWqNxdJKnPJ87vVlIcfVJ3YuOG3PASuz/T8fVsfBSkvnAqpuLfXBUAJQSIhQxcMKBxbtEvz
 9Ahj8hKuQaxvRwnb4SdhSdO+mXQdXEND/c9upcBDNO5gwYn0AgbM5nbFzOw/5yFLdlBaxF4L
 jiRjavEprJd2kubLyttTyeQh7IFiMRcog1OwX8DO0+NxIjPiMg36xsNoz45eQJYk0dc2OVpN
 2k3bEB4KM1iJduzaBSvgoxtJ+1AOPFd0kn21kdPi2DTCUWlPoAIwKvRJs7VlH31MUoFFtSYw
 F1c4HnoW3DmcakdGwMsDFV9paWLocNZr2X/dQPOIyhBN4Y3a3zpj8dCoIbORwTPWasMuaEMm
 QWmECucp0E22e78bpDX07Wn6Ik=
IronPort-HdrOrdr: A9a23:tl8utq/hWc3V8fCM/upuk+D8I+orL9Y04lQ7vn2ZhyYlF/Bw5P
 re/8jzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNCftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObOEYZmIbsS+V2njbLz9t+ri6GLvDv5ak856Bd3ARV0lYhT0JdzpymSBNLjV7OQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,215,1643670000"; 
   d="scan'208";a="28495096"
X-MGA-submission: =?us-ascii?q?MDGQr2eQQWBE4FW3q5fB0cnE5/0mJNWiP91Otn?=
 =?us-ascii?q?SRs7W41bwPjZyKr+399Mhan3QljmRPa0Y+KumA19dH7edeW7cakzL4t/?=
 =?us-ascii?q?5PhKTg1N5So1DrNf9jukYL2ErTJO4JF5CAQDWxgOowbhLlVGFbesGjoR?=
 =?us-ascii?q?NOjwJvsFjeA+JC0OIWpVniDw=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2022 13:31:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1648380701;
	bh=Ek5yiysvkH4JZanO3APOUltvqOKvgd9tXMX4TekVvEg=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=QbpCF73DYwyenwxV7ZUhk/E9LmL7PuHsokAM9d2nMc2s8+WkOAqpvYQQzOSPRE3zH
	 E8XU8ZgsxKakaqxUJ4fDQFD4e4trhq3tFsICYV/rCPZB3vzszXIL2UkradCE0nMgB8
	 bMb5kldteWW4RpEnBQaCbi9+14ZDsd3zdD7DCgWM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.165.68]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MBjIE-1nkZ8q2s5k-00C8TJ; Sun, 27
 Mar 2022 13:31:41 +0200
Message-ID: <243b180b-6fc3-1003-a592-1fc01bb198ad@web.de>
Date: Sun, 27 Mar 2022 13:31:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <c17bb3cc-f839-625a-66a6-2b9de96c9264@web.de>
 <alpine.DEB.2.22.394.2203252223110.4442@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2203252223110.4442@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V5JXzW/TS/IYj/xvOCQw6P/3xMRlUChZfZ4Lw0boNPNQ4WWcIHF
 gwIoX9uwYGGR5hz9i5/eFHUhDGqGWv0WNs6ySz5dfT1CnpRkZwXJCzGzYfF4WqSs5Y0kU0A
 2vNs1RdRWl86upoJ8x0tjlAakrT1gCG5gXNVepHbZL0gOl1PvKsEuW5rUKJMy+UW5TkUuPZ
 zhC4J911hUn6xfsOKybWQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:A0VklHZkkR4=:0ld0mmIjjZJ6K7yNxVs5sl
 aafH/7lfj4/i66qDF7EF88vjgBBnPcyN7Z/oBQC1jeo1DmuqLzQgWEJCTS6HuUPFAU1W2nDrg
 nk4i2nZRFZr/1oFR4yT5YtuSkdMm1+P77c/T000GOVzVddWu7iQAtCEAbI/azhCRo/qWRpfWr
 f/PczKdPsaknBBUONteNxSPoblnYyqaawQTxMY4Ix3/Z1yMFxDYBOV5RCVkP6E5zqd1BV8P+5
 fdudEyEZjxfAyTVQEb8qGPxeBE6l3yNMy9UEqS9XFjtiU46LXuD2R17maIJdgJ2XR99HVxDnI
 C4cOcvw9nvDgIyv2T/+gmU0Gu6R/Pj9IlUl1El1pXdVu4LsEHOBPRHSs5xqhCeYxBCRVTKoMI
 6lnr20UonDmaq9DaXdj5uJnzaDDVmOgQYDWtD8UvLT9gOzmK/kUqcFkec/TMokZWgBACp89qA
 o2TWvU2Zz0/aWpdUOl+i5IkEsZ0+Q398DvLVsysoSgsuFyprP5a5Ty0AWWusfcINUurfoiXzn
 29iHL48lIaMgt7emXy8UAYMK10vRnp6lBheMYD9h7Goo0D6X5UHaRdwCes8VkyqcySQoK9iQU
 IgyUFLAYA4n4MqwmlnW1BPJqvgrSbb/+iG7kHwWqHrfs7U5FCjxBVi7sIyRiYV+TVei2ToANV
 UrGekoQzWrqM86pZKaONM+wHRPa+5gORoeSyO9iiRG6XWMDWoQLDwEb5wl/IswfonY8YPvi4G
 23Fk6KUDbQYHCRDJfUjeC3dhfmedZDsUonR8fswV2RnYSVJGkx55wJxr7gZG/DaW81CDFhUs1
 vJr/AznieXSfGzl6Vl+YVFLBN07sSCYaOqkY0arvwk379sDuKt9duVtHU6scsTkZLRKxRS58g
 y33vywkkEDjnMbeJaN2+MmT2Wj+Gr+UIE3zM6+fcJmDKkK1mfSzGKY3xgNGBiVpvjg2lj2OQU
 tqUrhjrCBu9XC302XlQlUztnL3Ly05kpt6nSpKLwIMG5ocyzT7asCNMkNZyJH3t9k04CtEnU0
 LV1AiO+Fb8cTN9G5xcUwnWrTXlCYj4sjvBKm1VubXlgkolCZZwvUJz7TS2cyFdF+T4nEwtVvD
 qLHrj/ocC5v4iY=
Subject: Re: [cocci] Adding metavariable types for the handling of string
 literals?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 294
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/243b180b-6fc3-1003-a592-1fc01bb198ad%40web.de>


> constant char[] x; ?


How would you like to handle the following software development challenge
according to another SmPL script variant?


@display@
constant char[] text1, text2;
@@
*text1 text2

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> spatch --parse-c=
occi show_string_literal_usage3.cocci
=E2=80=A6
minus: parse error:
=C2=A0 File "show_string_literal_usage3.cocci", line 4, column 7, charpos =
=3D 50
=C2=A0 around =3D 'text2',
=C2=A0 whole content =3D *text1 text2


Regards,
Markus
