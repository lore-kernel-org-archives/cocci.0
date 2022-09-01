Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D626ECAAD3
	for <cocci@archiver.kernel.org>; Thu,  1 Sep 2022 15:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:date:message-id:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=cjOZy7jXz1uar+0YRSa4Ky/Yg+juiPiQxcldknSBEXE=;
  b=gqXyz3VgSoLyro+peYM4Nja8IwSLw4pBm+9ezgze5jzdscUjznJghfkk
   Kjqn417p8GY7JmNj8phtMA9zqx6Z6JaOJsJQaN5o5uZci1/Q+kICbzi64
   fpQmw2g+AD208cO60sft8HpNY5sBHTC1aGgHijUoVmeFmKq6ZhAxJY3aD
   E=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="5.93,281,1654552800"; 
   d="scan'208";a="50909755"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Sep 2022 17:11:04 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id ED514E779D; Thu,  1 Sep 2022 17:11:03 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 6AFF3E7799
	for <cocci@sympa.inria.fr>; Thu,  1 Sep 2022 17:11:02 +0200 (CEST)
IronPort-SDR: Cn9lendVijVSXeGypFOONW+anYVLA950Hge6zOeaDMGx3qiRPURLNLXl4WpN2bdhzr/J7ShL0a
 cwhkNCnDNIa3Y7WgXsHhXiOdFCxqXUiipMyVXk4v1EDRVEpzgU0j2+ZHyCXtHwpS42uWtZfML/
 sDsKOSBkjXuVKZjFBnqFdbLKYQGuUBqBbpdQ+AdIExt2B8nWJ2qF+TjgEXcsgpPyAvCqorEoBD
 As8CgRjvQlqKLcbcEBTYCCe8HeOWHDyQbcBhOw11lFYx6yTN4c+U5QmTo3cui9g/sW1PQH9PC1
 4VZfCxHinIk20rbJfktEjgVP
X-IPAS-Result: =?us-ascii?q?A0D7BAD7yhBjfy/QVdFagliCJIEBVy4EUAONSYgSjDSQU?=
 =?us-ascii?q?oF8CwEDAQwBOQcCBAEBPgEGgQ6IGgIdBwEEMgcOAQIEAQEBAQMCAwEBAQEBA?=
 =?us-ascii?q?QMBAQUBAQECAQECBAQBEwEBGAkZBw4OBWABYQMBQwGBTgGBTyoGAwEwDYI1K?=
 =?us-ascii?q?QGDfC4BGx4DEhBcAhEBBQEiEyKCXIJsAQMyAwQMngCBBEKMRwUXgQGCCQaBQ?=
 =?us-ascii?q?QGDDQoZKA1qOoEfAgEGCQEIEoEZhnyJRByCDYFLgj2DFYhfBIQNkxMEDgsPA?=
 =?us-ascii?q?wMCIQMaKx4CCQMjEQMLEAgUPQYCBAEBDAIBBAEFAwEEBQMHAgEFBgIJAwMJA?=
 =?us-ascii?q?wEBBQEDBAMDAwIHAwECDAQIAwMCAwQCAgICAQMCBwUIBAIHAgICAQICBgIBA?=
 =?us-ascii?q?wkBAgMFAgIJCwEEAgIDAQMBAQIIBAkEAgMEAgEBAwIBAgIBBQIOBQEBAQECB?=
 =?us-ascii?q?QECAwEGBwIIAhwKAQMDAwICBQICAQIDAg0BAQQCAQIBAgYBAwECAgMBAwECA?=
 =?us-ascii?q?gMCBgkCBAEFAwMCAgMBAQUOBQIEAgECBgUCAQEBBAEDBAQGAgIBAwMCDgIEA?=
 =?us-ascii?q?QQBAgEBIwMEAgMBAxcBAgECAwMDBAYHBQIBAhMBAgEBAQUBAgEBAwQEBwkDA?=
 =?us-ascii?q?gIEAwMFAQECAwIBAQEHDAICAhICEwMBBgEOBRQDAQEEAgIBAgIKAwECAgEDA?=
 =?us-ascii?q?gkCAQIBBSADAQEPJAEBAgICAgMEBwIBBAYDDQICAQEBBQYNAwIDCA0CBwMCA?=
 =?us-ascii?q?QMFAgIEAQIECgkBAgIBAgQFBwIBCAQFDQUJCwEBAgEDBwQDEQIFAwUFAwMCA?=
 =?us-ascii?q?QkBBQIDAQIBAQMEAQMEBgEBAgMCAgEGAgIBAQMDBAMBAgYCAgcCAwIBBAIDA?=
 =?us-ascii?q?wEBAQQCAgICAgMDCAMCCAcFAQYBAgEEAwICAQIHAQQBCAIBAwMFAwQBCg8DB?=
 =?us-ascii?q?QMBAwMCFAoFAQMIBgkCBAUCBQMCBAIDAwICCAMCBAMCCwMFBAIHEwcCAwICB?=
 =?us-ascii?q?QICAgICBQQDAQICAgICAgUCBAIBBQECAgECAgIEAQICBwQCAwEDBA4EAwICB?=
 =?us-ascii?q?wECAgEGAgcDAQIBBAMBAQQCBAECBQIEAQMBAgYCBAMKAgIDAgICBggDAwwJA?=
 =?us-ascii?q?gMFAgQBAQIHBAICCwEGAgcCAgMQAQMCAQQFBQMDAwkCAgMCBAICCgEBAQECA?=
 =?us-ascii?q?gEFBQIEBw8CAgIEAgICAQMCAgEBAgIFBAkSAQECAwYEBgUDAggYAQYCAgEBA?=
 =?us-ascii?q?gICAwMCBgIBAggCBAEEBQIBAgICAgQBAwYCAwEBAgECAgMDAgEEAgQDAwECA?=
 =?us-ascii?q?QICAgMCAgIDAgIBEAIGBgECAgICAgMCAgECBgECAQIEAgcCAgQDAgECAgUCA?=
 =?us-ascii?q?gIDAQEGAgQLAQMCBwYBAwIHBQIDAQQDBAMDCwUMCAEFAQMBIQMCAggCBwIBB?=
 =?us-ascii?q?QMFAQ8DAgIDAgIBBAoCAwUCBAIBBAkHAgQBAgkDAwYCBwUYAQICBwQMCgICA?=
 =?us-ascii?q?gUGAgQBAQIDAQICAQIDBAIDAgQFAQUCAQIFBAICAQECBQIMAQIBBwYCBwMCA?=
 =?us-ascii?q?gIDAQQCAQIBAwMCAwEBAQMGBgUJBAIDAwYCAgIGAgIDAhIDCgIGAwIEAQ0PB?=
 =?us-ascii?q?QQHCAECAQECBwIEAgcJAg4CAQYBBwICAwICAQQBAgEGBAcBAwICAgICAgUIS?=
 =?us-ascii?q?JVlgggHgQ4BK4FlOh6sboFrki5uYYITaIsrlS2WZpIQlweNOZl/AgoHBhAjE?=
 =?us-ascii?q?oEzCCuBW00jFTsxgjYTOwECAQEBDQECAQEDAQIBAgEIAQECAY4nF4NQhRSFT?=
 =?us-ascii?q?D80AgEBATYCBgsBAQMJgjqDCiYTCwGESQEB?=
IronPort-PHdr: A9a23:jKNFcBWsOKz4o5tYMXRqHIWmJHvV8KwNXzF92vMcY1JmTK2v8tzYM
 VDF4r011RmVB96dsaIUwLqL+4nbGkU4qa6bt34DdJEeHzQksu4x2zIaPcieFEfgJ+TrZSFpV
 O5LVVti4m3peRMNQJW2aFLduGC94iAPERvjKwV1Ov71GonPhMiryuy+4ZLebxtGiTanf79/L
 xa7oQrSu8QWnIBvNrs/xhzVr3VSZu9Y33loJVWdnxb94se/4ptu+DlOtvwi6sBNT7z0c7w3Q
 rJEAjsmNXs15NDwuhnYUQSP/HocXX4InRdOHgPI8Qv1Xpb1siv9q+p9xCyXNtD4QLwoRTiv6
 bpgRQT2gykbKTE27GDXitRxjK1FphKhuwd/yJPQbI2MKfZyYr/RcdYcSGFcXMheSjZBD5u8Y
 YUREuQPM+hXoYryqFQStha+GRWgCfnzxjNUnHL736s32PkhHwHc2wwgGsoDtW3KrNrvLqcZT
 Py4zLPOzTXNbfNO3y398IjVeR08o/GDR6hwcc/Lxkk0EAPFiEibpIv/MDOLzOsNqXKU4PF7W
 OKgjm4osQBxojy1ysgwjYnJg5sYx1bZ/ip23Ig7P8e3SFJnYdG6CptQsTmXOot5T88/XW1mt
 js3xL0ItJC7YCQHxpoqygPQZvCbc4WG7A/uWeWfLzl3mX9rdq6zihm8/EW81uHyWMm63VZEo
 ydDj9LCuHcN1xnJ5ciGTPtw5kih2TeT1wzJ6+FLPFg4lanFJJ47xL4/iJ4TvV7EHi/sl0X7i
 rKdeEY8+uWw9ejrfrHrqoWfOoJ0kA3yLLgil8+lDek3MAUCR2qW9Oam2LH98kD0Q69GguA1n
 6TXqpzXJ9kXq6ikCAFPyIkj8QywDzK+3dQYg3YHKFVFdQqCj4fzOlHOJOn0AumijFixiTtry
 f/LM7/7DpXCKXjDl7jhfbJj5EJG1AUzytVf64pVCrEHPv3zRlf8uMLEAhI9KQC5wObqBM9j2
 o8CWm+DGKCUPaHKvV+N/O0vIu2MZIEPuDb6Lvgo/+ThjWEjll8HZ6amxoAaaH+9Hvt8IkWZZ
 WDgjcsGEWcPpgY+Svflh0WYUTFPf3ayQ7485jYjBY67FYvDXJyigKSd3CenGZ1bfnxJCleQH
 nj0doWJQOwMaSKXIs95iDMIT7mhS4k71RGvrgD20bRnLvCHshEf4Lnk39N04eDXkRx60Bg8W
 8+a2GqMZ2ByhGIBATEsivNRu0t4n/md2LIwquZeG97N/WsBeAUzL5vV1Ot8Q4T7RAvbd92hR
 1OvQ9HgCjY0GIFii+QSalpwTo3xxivI2DCnVvpMz+Tj7P0c96vd2yO0PMNh0zPd07FniVA6Q
 8xJPGngh6hl9gGVCZSa216BmfOMcqIRlDXI6H/F1XCH6UhGWRR5W43KWHkeYg3dqtGqrljaQ
 eqWAK88ehBE1dbEL6JLbtPzilATTenqIt3US220kma0Qx2Pw+DEd5LkLkMa2iiVE00Yi0YT8
 HKBYBA5HTukqnnCASZGEFvuZwbh/bA7pi/kCEAzyA6OYgtq0L/dFgc9o/uaRrtT27sFvHxks
 DBoBBOm2MqQDdOcpg1ndaEaYNUn4V4B23iL/wp6doetKaxvnDt8O0x+ol/u2hNrC45Bjdlir
 XUkyxB3IL6Z11UJfi2R3JT5MLnaYmfo+xXnZ6nT01DYmNGYn8VHoP0mok/qtimmE0Mj9zNs1
 NwUm3qQ65PWDRYDBIrrWxV//Bx7qrfGJyglstmMhDs8bO/u6m+Eh416YYltggytdNpeLq6eQ
 Qr7EslBQtOrNPRvgF+xKBQNIOFV8qcwecKgbfqPnqCxb4MC1Hqri3pK5Idl3weC7S15H6TBw
 Z8fyvuw0Q6OVjO6h1Ck+JOS+8gMdXQJE2yzxDKxTodPb7d7d64EDG6vJ4u8wdA01Nb9HnVf8
 lCkHVYP3sSkLAGTY1LK1gpVzU0LoHajlENU1hRMmioy5uqa1S3KmKH5cQYff3VMXC9khEvtJ
 o69i5YbWlKpZk4njknt6UH/zqld7KNxSgubCU5WdjL/JUltV6KxsvyJZMsH5J4zsCpRWfixe
 hjAEu+780ZciXuzWTcBjDkgPymnoJD4gwB3hAf/ZD5ooXzVdNsxjRbT6drAROJAiz8PRS12k
 z7SVRC3O9ik+8nRlo+W6LjvETL8EMcLIW+3ktDl1mPz/2BhDByhkurmn9TmFVN/yirnz5xxU
 j2Oqh/gY47t3qD8MOR9f0AuCkWvjqgyUox4jIY0g4kdnHYAgZDAt3MZmH36O/1U3Kv/aDwGQ
 jtBkLu3qED1nVZuKH6E3dezX2uU2MJrT9a/a2ISnCk66ooZQLfR57tCkyxvp1O+pg+Eevlxk
 AAWzv424WIbieUE629Phm2NR6ofFk5CMWnwhgyFupqg+b5Paj/lIvCgkVBzlte7APSerxFAD
 TznL4w6E3YVjI03MUqQgiaurNi1IJ+KMY1V7lrOz1/Bl7QHds53zKFRw3M5YSSl+iR0g+8j0
 U4wg9fj5NLBcyM1u/jhZ3wQfjztO5FNpHe30fcYzp7Qh8f1Rt1gAmlZA8GuFK7uSWNI86ygb
 lbGESVg+CjHX+OFQEnHrh8h9iyqcdjjNmnLdiBBnZM7G0bbdAoHx1pNFDQiwsxgSVvsnZ29N
 h8/vndIuBb5skcekLo5cUmiFD6F9EHwLW5rLfrXZBtOslMYvhmTbJzYt7MpWXkfp8zprRTRe
 DbCOUISVjBPARbCXxe6b/G47N3EuYB0H8KYKP3DKfWLoO1aDLKTwI63l5Bh53CKP9mOOX9rC
 7s63FBCVDZ3AZaRnTJHUCERmy/XCqzT7B6h5i16qNy++/X3SUru44WIEb5bLdRo/Vi/n66CM
 +eagCsxJyxf09sAwnrByb5X21B36Wkmbz62DbEJrjLAVorVk65TShMXMmZ9aJQO4KU70Q1Af
 8Xcj5K917J1iOI0F0YQVVHlnZLMB4RCKGW8OVXbQUeTYe7edHubnoetOfP6FeID6Ycc/we9s
 juaDUL5azGKlj2yEguqLfkJlyaDehpXpIC6dB9pT2nlVtPvLBOhY7oVxXU7x6M5gnTSOCsSK
 z95JglEsLSK5ClwjfB2GmgH5X1gZ7rh+W7R/6zDJ5AavOE+SDxzjP5f6W8mxqF96ShFQLl4l
 HKXoIIx5V6hleaLx3xsVx8E+VMpzMqb+E5lP6ve7JxJX33JqQkM4WunABMPv9J5C9frtsi4L
 /DAkavyLHFJ9NeGpaP05uDRIcODdXctaF/nRGGSAwwCQjqmc2rYgh4F+Bl93nKQp5k+7JPrn
 chXIoI=
IronPort-Data: A9a23:k2xO467OKzW9dI9p30N6XAxRtOrBchMFZxGqfqrLsTDasY5as4F+v
 mFOC2qOPa6JYGr0eowib9ux9k4HvJSDx95nGgc/pX83Zn8b8sCt6faxfh6hZXvKRiHgZBs6t
 JtGMoGowOQcFCK0SsKFa+C5xZVE/fjUAOK6UoYoAwgpLeNeYH5JZSlLxqho2eaEvfDjW1nX4
 YKq+pWFULOY82cc3lw8u/rrRCxH56yaVAMw5jTSstgW1LN2vyB94KM3fcldHVOgKmVnNrLSq
 9L48V2M1jixEyHBpT+Suu2TnkUiGtY+NOUV45Zcc/DKbhNq/kTe3kunXRYRQR8/ttmHozx+4
 I8QiaS5cRkTB5aSs6ckWSZ4PGJ4NoQTrdcrIVDn2SCS50jPcn+pzvk3SU9qYssX/eF4BWwI/
 vsdQNwPRkrb1qTmnfThErkq2ptLwMrDZOvzvllp0zjDBPwOTpXKQqGM7thdtNs1rpoUQ6yOP
 pZEAdZpRD6cXEZ/AQk6NLMRrrqPolPmcgdms2vA8MLb5ECKlFAruFT3C/LefdeBRO1Oj0OAr
 yTH+X74C1cULrSiJSGt93utgqrCkXq+Vt5NUrK/8fFujRuYwWl75AAquUWT+6SFskeGRehmE
 BI/uRMkkogdt0qgZ4yoN/Gnm0KsshkZUttWNuQ17gCR16bZizp14EBUHlatj/R25KcLqSwWO
 kyhxIy2WGQ+2FGBYTfMqefO9GLa1T09dDdaPUc5oR05D84PSbzfYzrKR9dnVaO515j7RW62z
 DeNoywzwb4UiKbnNplXH3iW2lpARbCTFmbZAzk7uEr7smuVg6b7O+SVBaDzt6ooEWpgZgDpU
 II4s8af9vsSKpqGiTaARu4AdJnwuajcYWKE3wQxRcJ/n9hIx5JFVdAAiN2ZDBc5WvvohRe0C
 KMukVgMusENZSPCgVFfOtvqUp5CIVfc+STND6iINLKik7B+cwiI+CwGWKJj9zGFraTYqolmY
 c3zWZ/0Ux4yUP07pBLrGbp1+eJ0nkgWmzmPLbillE/P+eTFNBaopUItagTmghYRt/Pa/m04M
 r93a6O39vmoeLelPHmJr99DfQBiwLpSLcmelvG7v9WremJOcFzNwdeIqV/4U4A6zalTiMnS+
 XSxBh1RxFbl1C/ILAyLbjZob7a2BcRzqncyPCoNO1e02ih7Mdz/svtHL5ZnL6M68OFDzOJvS
 6ZXdsiFBMNJQGuV9jkYa677s4E/Jg+gghiDPnb+bTVmJ8xgSgXF98XKZAzq8CVSXCO7udFv8
 bKl3wLfB5EEQl06XsrRbfuuyXK3vGQcyLoiBRuWfoELdRy1ooZwKiH3gvsmGO02KE3OlmmAy
 gKbIRYEvu2S8YI49d/+g6rb/YqkFu1JGFUDQzvW4LOwAint/mS5xLhGXuvVLyvWU3n5+fn7a
 OhYk6P8PfkAkAoYuoZwCewwn6c35t+qqrMDiwo4QzPEaFOkDr4mKX6DhJEduqpIz75fmA23R
 kPfpYUAaOvRYJvoQAwLOQ4oTuWfzvVKyDPc2vQCPxmo7iFA+rfaA15ZOAOBiXEDIeItYp8l2
 +oopOUf9xe71kgxKt+Dgy0IpX6AKGcMD/cuup0AWtS5jwMqzhRPbcWZBHOppp6IbNpIPw8hJ
 TrN3PjOgLFVx0zjdXsvFCiSgbAM28xW4B0ankUfI1mpm8begqFl1hNm8QMoElZfwCJB3r8hI
 WNsLUB0ePuDpm86mMhZUmmwMAhdHxnFqFfpwl4EmWCxo5NEjYARwLnR+Nph/Xz1N0pZdzlfu
 byUkSPrDWmsc8b20S8/H0VirpQPiDC3GhLqwKia8watRvHWogYJRoehYGMJr13sBsZZaIjvu
 7xx5OgpAUHkHXd4nkD4YrV2EZwfTRmFICpJRvQJEGbl243DUGna5AVi4Hxdti+AyzImPKN45
 wFTyhpzaimD
IronPort-HdrOrdr: A9a23:SazW/KqPZZfisHHFyriMg5kaV5oceYIsimQD101hICG9E/bo7P
 xG+c5w6faaskd3ZJhNo6HjBEDiewKlyXcW2/hpAV7KZmCP0wvYT72KhbGC/9SKIVybygcy79
 YET4FDEtHqSVB1gcHmiTPIderIA+PqzElrv4rjJrtWIj2CopsP0ztE
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,281,1654552800"; 
   d="scan'208";a="22628145"
X-MGA-submission: =?us-ascii?q?MDEAc6bnIQ/ePOrT+Vu6kmRWxuhFfQUUJyTET9?=
 =?us-ascii?q?KCLZnPJVmaOmLx0/vCWfM06Nv/w1A25IaOAGeFRDK2kTgOpPUVqzIxGA?=
 =?us-ascii?q?3IsSN1ZrDk4gm99ywPuLtlidI7aLQGP9WawXR0Be5GFC5iaTatPnkuq3?=
 =?us-ascii?q?axRkTAilKh+Kbb9cO5AZgvDQ=3D=3D?=
Received: from mail-ed1-f47.google.com ([209.85.208.47])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 17:10:34 +0200
Received: by mail-ed1-f47.google.com with SMTP id z8so14214481edb.6
        for <cocci@inria.fr>; Thu, 01 Sep 2022 08:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:user-agent:date:subject:to:from:from:to:cc
         :subject:date;
        bh=cjOZy7jXz1uar+0YRSa4Ky/Yg+juiPiQxcldknSBEXE=;
        b=bl09rZfWhoRSzaEz4rt3lXCWSXnz3+1h4Zkk4QrrEzetwpCQRnpW1lg+gK5KSHQ/et
         +nDG0w5sd36fM1mcaBJ1yZ5QxMFzH9UISStSJSphxybydWph0QexEC0COGM+RPKiOA/6
         uqZmOYZxmgd4jfVHAJ4niZHfyXElt0GfSGUV5O8icBNosPQoOnKdrJc+wdGenHUdbPt/
         i0SWkwJhXNjJXzvg7hlpVBzG2azHx1ZWoLnzD+/XMc0Uy0HIBeanj7o2p7DnpSRbYQ8D
         cEI2lQR8klT/1YwMNjtMxHrXJUFK/NL8/K4wwqn/4BpV0+trnfI5ITXO3kzxg1sbZJB+
         +zfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:user-agent:date:subject:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=cjOZy7jXz1uar+0YRSa4Ky/Yg+juiPiQxcldknSBEXE=;
        b=Hzdz/2W/2+wTHmSlwrDmXJjbRzRQeVVrRIacjtCgJfocQcy/QKDMslJBPcfBHo028Q
         4qFAa5Nw3vFDW4DulNB+UhjXMMfI2a3LucgABsXCFbbi3n18tAajDSODnJue//u58Okx
         e50HHxNSzk+ezySu3rzpVRvZgpcIDwlcysrNR/2BAKgprxQtFPn68uBKhBbaFc6Zm8BV
         RwgDmfTPJwj++nHxh/6d0a1zWl3azBLZe6NbzZU2V6tQJWq7j6mdYzKapug/2Q5n6oE2
         TcVY4DBtnzuOTTonXIIJHRkmXIN+DMl2P0yn/B3QTrjkmv+o2NsNq1AvpTrL9T3DC/ZL
         MCpw==
X-Gm-Message-State: ACgBeo0lOIATq+CjdrIQI8ZfUSHpQNkHzQQKsm0ppqKHEPtYhVEMZEwd
	Xo38UciGBk3UFN9erZaQrYM72cml/G9+jg==
X-Google-Smtp-Source: AA6agR7jgNYiUnsm+LsbXj9M6UATw9q/sFLYhsz66PE+uuB95Mvm+3JoB+XBG9MgnXkU0R6ti0+P3g==
X-Received: by 2002:a05:6402:4486:b0:448:de41:d582 with SMTP id er6-20020a056402448600b00448de41d582mr10380856edb.52.1662045032897;
        Thu, 01 Sep 2022 08:10:32 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id 6-20020a170906328600b0073d6d1990e2sm8704698ejw.140.2022.09.01.08.10.32
        for <cocci@inria.fr>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 08:10:32 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
	(envelope-from <avarab@gmail.com>)
	id 1oTlpv-000F05-2r
	for cocci@inria.fr;
	Thu, 01 Sep 2022 17:10:31 +0200
From: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Coccinelle ML <cocci@inria.fr>
Date: Thu, 01 Sep 2022 17:00:05 +0200
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
Message-ID: <220901.8635dbjfko.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [cocci] Optimizing *.cocci rules by concat'ing them
Reply-To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 531
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/220901.8635dbjfko.gmgdl%40evledraar.gmail.com>

Are there reasons for why $subject is a generally bad idea, i.e. given a
set of *.cocci rules in a directory instead of something like:

	for c in cocci/*.cocci
	do
		spatch --sp-file $c --patch . *.c
	done

Doing:

	cat cocci/*.cocci >ALL.cocci
	spatch --sp-file ALL.cocci --patch . *.c

I'm aware that rules in general may rely on previous transformations,
such that the 3rd rule in a file might not fire unless the other 2 have
previously changed the code.

But aside from any such undeclared dependencies, which surely I'll have
trouble with either way. I.e. I'd get to the 2nd rule in A.cocci, apply
that to my sources, and only then on a second run would the 1st rule in
B.cocci fire, but it should have been in A.cocci to begin with, and
depending on the 2nd rule in that file.

Are there reasons for why this is a Bad Idea?

The motivation here (and this is probably burying the lede) is that I
implemented a "spatchcache", which can cache previous runs of "spatch"
in a local Redis (or with a custom command, if you don't have Redis, I
started out with a dumb FS-based cache).

It uses the approach of piggy-backing on GCC and Clang's ability to dump
a full list of all the files that a given *.c file depends on.

This is usually used to drive better incremental "make" support, but I'm
(ab)using it to implement an "spatchcache". If the hash of a the target
file *and* everything it depends on *and* spatch's path, flags etc. is
the same I can cache the output of "spatch".

See [1] for a series to implement this for git.git. I'd previously mused
on this list in [2] about this approach (but hadn't finished it up until
now).

But even then git's fairly slow in running "make coccicheck", and of
course it does nothing to speed up an initial run. So concat'ing the
*.cocci files we use seems like a viable option. But I thought I'd ask
first in case I'm running into somewell-known caveat.

Thanks!

1. https://lore.kernel.org/git/cover-v2-0.9-00000000000-20220831T205130Z-avarab@gmail.com/
2. https://lore.kernel.org/cocci/211116.86lf1op65q.gmgdl@evledraar.gmail.com/
