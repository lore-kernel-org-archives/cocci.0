Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F4E2C48260
	for <cocci@archiver.kernel.org>; Thu,  8 Feb 2024 12:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=4kvi+Mxu9+IJ42Ql5SlzBW8pkp9c5+UZWArDgPma4JQ=;
  b=ToRjdSBkZ3Rf0xizzMFqWqJrjVltrWpMkb6LelA/H6hND1DSLFiBz3qX
   VU0Vfal3btWuN3stUVqTBklRn909DbaiW0wFB2UYH9OoFb9O8oYBq6tmH
   /anoMiu98fgxE2ssJyoAOnI0xIT6UN6obSt4ayTlzk+c8OVz98CGpiPQx
   A=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.05,253,1701126000"; 
   d="scan'208";a="150951406"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Feb 2024 13:50:36 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 70631E0CD5; Thu,  8 Feb 2024 13:50:36 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id A19C8E008A
	for <cocci@sympa.inria.fr>; Thu,  8 Feb 2024 13:50:31 +0100 (CET)
IronPort-SDR: 65c4ce16_EP5krQ4Y0MS/K3krE6KRTC7kzJwv1j3M2LmpM6/4YwaJESD
 A7+QdomDWeGhWnKJ2oRL//mN8v3V3rqG3nv1wWQ==
X-IPAS-Result: =?us-ascii?q?A0GqAAAzzcRlhwwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T4EAQELAYI4fANTMgQLSIRTkTotA4Q7jwWIcIMWPg8BAwENOwYBAgQBAQMDA?=
 =?us-ascii?q?YR/AodXAh4HAQQzBg4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECE?=
 =?us-ascii?q?AEBASMXBw4QJ4VsDYJcARCBDoEmAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQECDTpCAQICASMdAQERJwQLCxoCJgICVgYBEgIBA?=
 =?us-ascii?q?YJ8AYIqAQMOIwcNBrcGgTKBAYIKAQEGgUUCDAJDrUIfLCJWgWEDBoEaLgGIJ?=
 =?us-ascii?q?QGFboQ7Jw+BVUSBPIJSMT6CYQOBX4NbgmiCGIM8lzhUfx0DgQUEWg0bEB43E?=
 =?us-ascii?q?RATDQMIbh0CMToDBQMEMgoSDAsfBVUDQwZJCwMCGgUDAwSBMAUNGgIQGgYMJ?=
 =?us-ascii?q?gMDEkkCEBQDOAMDBgMKMTBVQQxQA2QfMgk8CwQMGgIbGw0nIwIsQAMREAIWA?=
 =?us-ascii?q?x0WBDIRCQsmAyoGNgISDAYGBl0jBw8JBCUDCAQDKykDIXQRAwQKAxQHCwd4g?=
 =?us-ascii?q?gmBPgQTRAMQgTSFPoMRAxkrHUACAQttPTUJCxsGPQKdDAGDRBMqAoEFgRoex?=
 =?us-ascii?q?Sc0B4I0gWCBYQyKGpUdBhMvly4OBpJemFcgi1iBd5sIgXkkgVwzGiSDNk8DG?=
 =?us-ascii?q?Q+OIBkfg3WBC4NWimZCNQI5AgcBCgEBAwmFRgEBg1qBRgEB?=
IronPort-PHdr: A9a23:r+uJjhYVxvN03XzUtqDS3Xb/LTHi2oqcDmcuAnoPtbtCf+yZ8oj4O
 wSHvLMx1g6PBdmQt6sMy7KP9fy6CSpYudfJmUtBWaIPfidGs/lepxYnDs+BBB+zB9/RRAt+I
 v5/UkR49WqwK0lfFZW2TVTTpnqv8WxaQU2nZkJ6KevvB4Hdkdm82fys9J3PeQVIgye2ba9vI
 BmsogjdqM0bjZF+Jqs+xRfErWZEcPlSyW90OF6fhRnx6tmz8ZJ57yhcp/ct/NNcXKvneKg1U
 bNXADM6Pm4v48HlqQfNRhaV6HsGVWUWnBtIAwzb4xz/Q5z8rCj0uPdj1SeDJcH5Qqw6Vjqk7
 6dwVR/nkzwHOCIj8GHWkcN/kqRWqw+8qhNlwo7UZIaVNOdifq7YYNgXS3ZNUtpXWidcGY63c
 ZcBAPQdMuZZt4n9pkUBrR2iBQm3GejjziZEimLq0aEm1ugsFxzN0g49ENIUqHnar9v7O6gcX
 u6o0qfIwzXNYPFK1jny84XIbgkhrOuQUb5sb8bcy08iHB7FgFWKrozlOiuY2OMXvGiB7OpgS
 PmvgHMopQF1rDiv3MYsio/GhokIzV3K8j92wJw2Jd2lU053e9GqEJ9etyGANot2RMwiTnpmu
 Skk0bIKo4O0czYTxZkh2hXQZOCJfZKS7RL/SOaePy14hHR9db+xmhq/80ytxO3/W8Wp31hHo
 DRInsfMuH0DyxHe69SLRPVj80mh2zuDyQ/d5/1KL007lafWKpEvz70+mJcNrEjOGDL9lkvxj
 K+TbEok++6o5vzkYrr4vJ+cMZF7igXkPqQpgMy/Dvw0MgkIX2iB+OSzzqfv/UPjQLhMk/Y4k
 bHZvYjEKcgGuKK1GRFZ3pgh5hqlEjur0s4UkWQZIF5dfB+KgJLlNl/TLPziDvqyjU6gnTNry
 v3AI7bsHJHNLmXYkLf9Y7l98VNSyAsyzN9B/59YFrcMK+/pVEDrrtzXFBo5PhS0w+n5DNV90
 ZsTWWeIAq+ELKPeq1GJ6fw0LOWWeYAapi7xK/kj5/HwkX80gUERcbS30ZcNdny0APZrL1+Eb
 XfumNsNDHkGshI7TOPwiV2CVTBTZ2y1X6I5/jw1D5ipDZ3ARoCwm7yNxii1HplYZmBcC1CMF
 3joep6KWvgScy2eONJunSIcWbinUIAuzQuuuxPiy7p7MurU/TUVuYz72Nhv++LTjQ0y9SBzD
 8mFz26NSH17kX8JRzItx6B+oUl9yk+Z3qRigvxYE8ZT5/JTXQsgO57c1fR2C8ruVQLZYteJV
 FGmT82iAT4rQNM+2dsOY0JmFtSjjxDD2jGlA6UPmLCRBZw09Ljc33nrKMpnxXbGzvpps15zY
 NZLNGTuoqdg/gzXT9rLjkGYnuCufLsV2Crl9WGZzGPIslsOFEZ7Vq7OXFgeYFHXpJL3/BDsV
 birXJEuKAhc0oavLqVQa9vmxQFjTe3gJc+YTma/gWa2Cj6Xy7nKYIe8KDZV5znUFEVRy1Nbx
 n2BLwVrQ375+wo2bRRrHFPrOAb39PVm7Wi8Vgkyxh2LaEto0/y0/AQUjLqSUaBbxaoK7QEmr
 Tg8B1Ohx5TOEdPVggN7f7hHJ/457k1G023xqAF3eJCtfOh5nlBLSw1spAv10glvTIBJkMwkt
 nQvmS97M6GFyxVscz2C3Jb/EqLaIC/+8UPncLbYj3fZ1tve4aIT8LI4plHk6RmuDVYn+m573
 sN91nyB+tPVAQBUXZ+Zvl8f0R98qvmaZyA849iRznhwKeyvtSeE3ds1BewjwxLmftFFMarCG
 hWgW8sdT9OjLuAngT3LJloNIfxS+agoPsina+rO2ailO/xllS6nimIP6Z5000aF/S5xAuDS2
 JNNz/ad1wqBHzDy6TXp+uX+g4NZfnc/GmSlyC7rLJFcbOt+cMdDCGujJdG22sQrn4TkCDZT8
 F+uAU9D2df8I0PIKQangksJigJO+y/C+2Pw1TF/njA3o7DK2SXPx7+nbx8bIitQQ3Eki17wI
 I+yhtRcXU6ybgFvmgH2gCSyj6Vduql7KHHeBElSeC2jZURrSKitrfyvZ8BV6ZUnmTpaWqKwb
 BrJL9y16wtfyC7lE2ZEkXoefiupp46/shh0kmObI15soXCfdcw6lnK9rJTMAPVW2DQBXixxj
 zLaU0O9M9ee9tKRj57fs+q6WgpNT7VreDLwhcOFvSq/vihxBAGn2uu0gpvhGBQ71iny059rU
 z/JpVDyeNuj26O/OONhNk5mYT20o+9zAIJjic0dgJ8K2H4VroqY9zwLnC//PM5a1qT3cHcWD
 WRSmZiPulejgRIldyjBzpmxTniHx8p9e9S2BwFekjkw6cxHEubc7bBJmzd0vkvtqAvQZfZnm
 TJOgfAq6XMcn6QIoF93l3/bWOpNWxAHe3W2xHHqp5ikoa5aZXiia+213Ut6xpW6Ca2a5xpbQ
 DD/c4sjGil56oN+NkjN2Tv98NKBGpGYYNQNuxmTixqFgfJSLcd7s/MQhjd8f0/5s2ckzeETk
 hFkm5239tviSS0l7OeiDxhUOyegLeYa4DLwluBzmsiM3oagNopsEHMHUdG7KJDgWCJXvvPhO
 QGUFTQ6oXrOArvTEziU70J+pm7OGZSmZDmHYWMUxtJ4SFyBNVRS1UoKCS4ikMdzRWXIjITxN
 V107TcL6hvkpwtQn6h2YgLnXD6XrVWtbSooDoeSJlxa40lLtULSLNDb/ux0BT5R5JHnswGHb
 GCWAmYARWhbX0uZGxXpOaSo7tSG7OWSQOazZ/KcZLKTtalVTP2VwZHpi4Jg82/KPcKKWxsqR
 /Rp301eQTVyAM/egS1JEiURm3uLZMme7AG1/ik9xiym2NLsXg+npY6GCr8JdM5q5wjzmqCbc
 eiZmCd+Lz9ckJIK337BjrYFjhYUjGl1ej+hHK5l12aFRb/MmqJREx8Qaj9ifMpO4aUm2wBRO
 Mndwtrr3798h/QxBh9LT1vk0s2uYMULJSm6OjalTA6TM6+aIDTQ38ztSaa7VKEWk+he8RG9+
 H6aH0LlIjWfhmzpWhSoYoQuxGmQOB1Tvp34cw44UzG5Coi8NVvib5ku125To/V8nH7BOG8CP
 CIpdkpMqubV9iZEmrBkHHQH6HN5LO6CkiLf7u/CK59Qv+E4Z0Y83+9c/nk+zKNYqS9eQ/kg0
 g7btN1zuBeLlueVyzxoeAVDoHBHicjY2CcqcbWc7ZRGVXveqVgV6n6MDh0Ru9Z/ItjoprwW1
 dXF0q7+YmQnkZqc7Y4XAM7aL9iCOXwqPE/yGTLaOwACSCaiKWDVg0E1eB666XCf6JQ3+MGEc
 HsmT7hGSBoqG/lcBkk3RLTqxb9oUzlinbPJ1KY1
IronPort-Data: A9a23:7MUYbqhucwcGu9UqGgZ+Ky5OX161WRQKZh0ujC45NGQN5FlHY01je
 htvXG2Pa6rYamb8Ktp0OYqz8UNX7JDRzNE1SlFp/ig2EiJjpJueD7x1DG+gZnLIdpWroGFPt
 phFNIGYdKjYaleG+39B55C49SEUOZmgH+a6UqieUsxIbVcMYD87jh5+kPIOjIdtgNyoayuAo
 tqaT/f3YTdJ4BYqdDpJg06/gEk35qiq4mtI5gVWic1j5TcyqVFFVPrzGonqdxMUcqEMdsamS
 uDKyq2O/2+x13/B3fv4+lpTWhRiro/6ZWBiuFIOM0SRqkQqShgJ70oOHKF0hXG7JNm+t4sZJ
 N1l7fRcQOqyV0HGsLx1vxJwS0mSMUDakVNuzLfWXcG7liX7n3XQL/pGU1t1B4BC1OVOLnBl0
 cwJCzUvUCKxmLfjqF67YrEEasULKc72IMUAt3smwTyx4fQOG8mZBf+QupkBg3Fp3KiiHt6GD
 yYdQR9mdhfdeFtiPlkNCZQxtPiljD/zflW0rXrK9PNvuTOLkGSd1pDQF9Xkese0b/5xlwWd+
 G/h/z/2KSMjYYn3JT2tqS783rSfwksXQrk6H7qz/f9Cm0yW3mVVCRsMVFL9r+PRokq3RNtbL
 2QG+y8kt6F09UqxT9C7UQfQnZKflhsbRsYWDOAwrg2AokbJ3+qHLjceDQRMMvIljeAnbhgax
 3yMve3bNyM65dV5Vkmh3ruTqDqzPw0cImkDeTIIQGM5Dz/L/t5bYvXnEIgLLUKlsuAZDw0c1
 BimgUADa1g7iMkWy+Ok8FqBjz/ESnn1ouwdtlm/soGNt10RiGuZi2qAtAizARFocdnxc7V5l
 CJY8/VyFchXZX13qASDQf8WAJai7OufPTvXjDZHRsZ5qG/9py7/INAOulmSwXuF1O5bJVcFh
 2eM5GtsCGN7ZiL3NMebnqrqUJpxnfSI+SrND6iMMYEmjmdNmP+vp30+PRXAgAgBYWAtlqc4I
 t+AfK6R4YUyWcxaIM6Nb75Fi9cDn3hgrUuKHMyT50r9jdK2OiXPIZ9bawTmUwzMxPjZyOkj2
 40DbJTiJtQ2eLGWXxQ7BqZKdgtUdidqX8ueRg4+XrfrHzeK0VoJU5f5qY7NsaQ/90iMvraWo
 COOSQVDxUDhhHbKDwyPZzoxIPnsRJtz5zZzdyAlIV/iiTBpbJeN/ZUvUcI9XYAm0+h/kt9yb
 f0OIPubDtp1Fz/oxjU6bLvGlrJESiiFvwy1EhCeUGANRKI4Hw3t0f34TzTr7xgLX3aWt9Nhg
 riO1TH7YJskRiY5Pvn3dcCA8lKVlloekdJUQEHnDIRyekLt0Y4yMA33rKY9DP8tICX55Amx9
 lipEzIHg9LSsqkJ8NXtroKVnbeDSudRMBJTIDjG0OyQKyLfwFuG/aZBd+S5JRbmS2L+/fSZV
 9V/lv3THqUOowdXjtBaDb1u8KMZ4unvrZ98yiBPPi3CT3avO4NaDki25+t9nYwT+eYBoiqzY
 FyFxfdCM7bQOM/FLk8YFDB4Usu9j8MrihvgxtVrBn7l5R1H3quNCmRTGBiutBZzDpVINKEd/
 ONwn/JOtiKejEIxP8eknxJk0T2GDkY9XpUNsrAYB47WiTQX9GxSXKyENAjI5MCgVtYdFGgrP
 T6eu4TajZt+2EfpUiQ+BFrN78VnlLUMvxFGlmEDA1GznvvEmf4F8xlD+hsnTglu70tm0sAiH
 kNJJkFKNaG10DMwv/d6XkeoABNkKCCC307Ml2syi2zSSne3Wlz3LGESPfiH+GYb+Tl+egd30
 a65ymG/dxrXZ+D0gzUPXHB6p8zZTdBe8hPInOalFZ+nG7g4eT/Uvb+8V1EXqhfIAdIDu2Ofn
 LNEpN1PUKzcMTIch4YZCIPAjLQZd02iFVx4GPpk+PsEIHHYdDSMwgOxEkGWeP5WBvn04ES9W
 t1PJMVOakyE7xywjAsnXIwCH7wlu8QSxosmWqjqLms4obegvmJXkJbPxBPf2k4vYftTyPgYF
 K2AVgi/AlSxhGRVkVDjtMNrGHS1SvhaaRze3NKayvQoFZUCut49KE0Zj+CGgFSIAiRa/ja/n
 gDKV4nJxcNMlKVumIrNFP1YJgOWcNncasWBwDqRgf9vM+zdFNjothwHj3XaJCFUAOchYMt2n
 rGzr9LH5kPJk7IoWWT/mZPaNa12yeitfehQaOTbEWJ7mHacZcrS/BczwWC0BphXmtd75MP8Z
 Q+ZatO1ROEFSeVm23xZRChPISkzU52tQP/bmhq8iPCQBjw28w/Ndoqn/EC0S1BrTHYDPpmmB
 zLkv/qr2Mtjk71NIx05HNBjPY5zJQ7yeKkhduCpjwKiMEuTvgqgtIfhxD0a0hOaOkncRYy+q
 djASwPlfRu/hLDQwZsL+8ZutxkQFzBmjfN2YksZ/MVshiunCHIda94QKogCFooehxmaOEsUv
 90RRDBK5eTBsTV4ndHU5dP+QkGAC+ZINtqRyvnFOa+LQ3/eOW9CKOIJGuRcD7NeZTbpiu2qQ
 T3b0mOlJQC/m/mFWs5KjsFWQo5bKjfy2X8Cv0zw+yA379DyHp1SvEFc8MFxueAr3i0DeIgn5
 YT4eIycfHyGdA==
IronPort-HdrOrdr: A9a23:VSGBxqOKH49RV8BcTvqjsMiBIKoaSvp037By7TESdfUnSL38qy
 nOpoVj6faaslYssR0b9OxoW5PwOU80l6QFgrX5VI3KNGKNhILCFu5fBP7ZogEIbBeRygcy78
 tdmuNFebnN5BBB/KHHCSeDYrAd/OU=
X-Talos-CUID: =?us-ascii?q?9a23=3A040lBWh0yt1u9NQMJ0WPZsH/ajJuLWee9nqKDUy?=
 =?us-ascii?q?BJndCbI2EalqyxpFWjJ87?=
X-Talos-MUID: =?us-ascii?q?9a23=3A31gjnA5MZr0iW0wX0Nn8+29BxoxVxKufCFszu64?=
 =?us-ascii?q?isoqBayFXO2ySpwaOF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.05,253,1701126000"; 
   d="scan'208";a="79102304"
X-MGA-submission: =?us-ascii?q?MDEUS4A6glEcuUBG64S6T96a8rb84Npm+DRHat?=
 =?us-ascii?q?s+c9jmmTnC/1TfzMJvJzSqmUtTaylWCMpUuMkrqfOY0KGR65NlLsdB/t?=
 =?us-ascii?q?NuKrwFditL/Z6w7Z5dT7cETG5fVXom2InptXhseblRgPQnMc9NLQ1ghR?=
 =?us-ascii?q?sgChmnKjk4grwBum3Di0migQ=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 13:50:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707396629; x=1708001429; i=markus.elfring@web.de;
	bh=OGwdpCc5X/Exvti5rJBzJM2YMgfekL4cQGsq5AyRwxw=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=MmGcidQ66GAun8c3vxDO8mE0mGCvJIc24kxM2p8JKIK8v65VEXlZJAYsWpb6rhCF
	 UGL9BP6L08smudAWwEkiHEft59xPMNLXAVU8DH4zvZiEN3RcKf3laf10BQFgBzjrl
	 74iTYpYAQOTBOOsNUhpAd65r/zZrK2vy2HGGmALqRxQz/mgdzvZknomcRlK1iCGu8
	 6Nb2S+j3zeeZ0odtNQGrTn+B4O8Ls8iYUQzeJ8oIAI1IWorXiJQqLtHKy2/L2l6+G
	 Ei/1OEw/X0LeHk6YIL7cu7S0UjVJpdGtid7ojK8sfuraJCkkuPk6cz5oYxPyUDwA2
	 VphR8hJT9fupcPszzQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MaHSp-1rSogS26pJ-00WO0G; Thu, 08
 Feb 2024 13:50:29 +0100
Message-ID: <1f8cb65b-715f-404c-84f7-8eee6de02352@web.de>
Date: Thu, 8 Feb 2024 13:50:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <dcb996ea-f041-406e-b641-0e6b515b9a0a@web.de>
 <7639c70-41e8-9a1-3a5-3a7711fc465@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <7639c70-41e8-9a1-3a5-3a7711fc465@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:j9LoiqvrKaGxFjpOXvCtUzHE58IMV4voFJJV8zxPs95sDuooNNW
 mrcR8SGiaXNK807DjO1R6SsMJBftAGJkqPusM+sdVZKI9RRkAPNw4Tmjfz/egY8REbuUjx8
 1FHGjpOSLG9mtBKpI8N5XQgCPdB5wc2x14eIgU36RtCVY0TKkenBesUyYhXm33fYq0Nnr57
 HXz+KK+emWooS00UnMHPQ==
UI-OutboundReport: notjunk:1;M01:P0:qS0S/+I9CrM=;UUrt+fyun4dZg/7Y8y/8PgMaJ5A
 jR+nL1QBUj1b7zKmnjVarg67m1V+snBRRkWTVaoJsV0WgdfEEUNH/ZPfVqGVnWAKKotFHu0KQ
 WDClQ8EvRO1WpJEt1tgxl31D1BCgSLiQL0NhqTVr/jbqlHfzPq5/TM2ZKqLzVS1CBEPvL65VT
 8cb1p14VynuejkPEiOhuaaRLZqFgkA9PHcVtRQUxpTPRkPsVbLA8G9iLOCluf9klYQ29415Bh
 BfeqscF+O0B8bp91Zr4sEB4D0fTTI/4Yew9iRiv+5K6uXG20SsP6REQDro7iz4NA4M0308nhX
 V2NMTXQaCVSXgv8LHDVSztsp+U0U5szVszub7+JF4rXnAOJ1TBQ9EO1egn6zSXwfEDptS2nOw
 3yyfPcEYR8p1AD5XpFzKQb/haEQqW01fT9qlIupqbS1+SG+VL/SgrZR/f9RiaZ5sMUpHQ4YNW
 NFcP8XSdRWAJYIRGPXccA2oFg2S25OrKVM7f/JHhowndRP9qZrgiFbOU8rrFcWhQbCL5eEj0q
 WYIJQG2gDB5ve4VXSjr6cn8ELVoH+eltJroK5vX9KuKlqy8MYCBXsmzf0cQNODZOsVyqxC1mS
 BXcnMewOKlQ+BCy3bVqMh3WVpFIRq8BqmydLOK405FTJMcxiOow4f1N3ipPW345qlW8f0hWi8
 2cO9Th/8egQKnyhUP5x0qkw3SG1I1Q0Jm7u9ErgqoQdBcwFzHpnm9AcNTwBOo3s4Hd1w3eNdC
 uwLJfYskcNHc5/3wUll/Y21X+n4R4gBrjRCCBCkhZRTFxPaSJ6pFlhcj453jfXz0PmAM1Li+L
 3iWxK7C94W0OCDmu2e9idGgR4y/oYauA5NIk7faM98asc=
Subject: Re: [cocci] Improving support for code positions with opposite SmPL
 dependencies
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1514
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/1f8cb65b-715f-404c-84f7-8eee6de02352%40web.de>

> I don't really know what you are trying to do, but the:
>
> <+... var ...+>
>
> seems unnecessary.  Maybe just
>
> ... when exists
> var

Would such source code search specifications be equivalent finally?


> Furthermore, I don't see the point of repeating:
>
> t * var@declaration_pos;
> ... when !=3D var
>
> Once you have the position call_pos, I don't think that adds anything.
>
> Likewise in the adjustment2 rule below.

This development concern is more relevant for the clarification approach
=E2=80=9CSupporting transformations better according to reduced number of =
function call parameters=E2=80=9D.
https://lore.kernel.org/cocci/289a052b-86ff-4ecd-ae55-89fc0238373e@web.de/
https://sympa.inria.fr/sympa/arc/cocci/2024-02/msg00017.html


>> Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> spatch --pars=
e-cocci test2-switch_opposite_dependencies-20240208.cocci
>> =E2=80=A6
>> meta: semantic error: position cannot be inherited over modifications: =
call_pos
>>   File "test2-switch_opposite_dependencies-20240208.cocci", line 28, co=
lumn 44, charpos =3D 572
>>   around =3D ';',
>>   whole content =3D position find.call_pos, find.declaration_pos;
>>
>>
>> Will source code transformations become better supported according to
>> opposite SmPL dependencies?

I would appreciate more constructive feedback for this test result.

Regards,
Markus
