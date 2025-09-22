Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 679C1CAC5A7
	for <cocci@archiver.kernel.org>; Mon, 22 Sep 2025 11:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=aGbRtuP0hUze/B2mpfPvy8t/jhHyTV6F9aN6VZtO1fI=;
  b=Hto0djqRI1MjDBLJFdek2GXRyhOQ6Ln0FJ8gZzbUy0+LnsHNKl1dO9l5
   1tf9zoNAo+vqwBe5gjKjqG3s4iGG3oCON2HzpSeKjsrV36QXBGBred0EG
   2xmE22QrO5IlwlkgtECzrdOTfNsdbnYDLNj53zlrO7jpT4gUsGBtL5ndd
   Q=;
X-CSE-ConnectionGUID: 0F9XZEn7THeYecQ9ACwXFg==
X-CSE-MsgGUID: JeG2RKP5SL+WZQDhSi7/AA==
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.18,285,1751234400"; 
   d="scan'208";a="240399981"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Sep 2025 13:23:25 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 90D4BE0C55; Mon, 22 Sep 2025 13:23:25 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id CD5CAE0BE9
	for <cocci@sympa.inria.fr>; Mon, 22 Sep 2025 13:23:18 +0200 (CEST)
X-CSE-ConnectionGUID: 3P+GLv+zR6yyh7PPNo0vOQ==
X-CSE-MsgGUID: AZikLpj8Rx+q+SzZzd22nA==
IronPort-SDR: 68d131a6_P+K7WeTj4ET8gf/qGcVhtPzUWy7CuTx4ECs9HtEjHk0ZLLQ
 4wCtP7yRnU5a8uti5qF/D/afjnyaYUdbZwdfqxQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HSBwCRMNFog07ASNlagQmBU4JAZR0GVDMEC0kIhE2PU?=
 =?us-ascii?q?IIhhD6PEYh5gVWBQD0CDwEDAQ09EQECBAEBAwSRQAIeBwEEMAkOAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABAQE6Bw47hk8NgluBLF5IA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBEQIwFyRJHQEBESc0AiYCcwEBgn4Bg?=
 =?us-ascii?q?iIBBhABAzUHDQa2Z4EygQGCDAEBBoJp13YfLCJZgWQDBoEbLoVsgkoaAQVui?=
 =?us-ascii?q?hcPgVVEgTyHOyB2gw6CaYIRFYEWg1g2giiBIohZjG6BShwDWSwBVRMXCwcFg?=
 =?us-ascii?q?WMDgQ8yPDIdgSeDfoENhB4rT4UCPlqDUyRrDwaBFYNbhzRAAgELbT03CQsbB?=
 =?us-ascii?q?j2XG4NHTVdPLJRWKLF3gQo0B4I4gWcFgV8MiQiBJpU+BhMvl1IOBpMFmQaOC?=
 =?us-ascii?q?JVghVmBaDqBXDMaJIM2TwMZD446JYN1hGDCR0E1AgE5AgcBCgEBAwmFRgEBj?=
 =?us-ascii?q?CI0gUsBAQ?=
IronPort-PHdr: A9a23:C1Ep0BVQrOnBcdY/EcaXicuLj8TV8KwPXzF92vMcY1JmTK2v8tzYM
 VDF4r011RmVBt6ds64P1rWJ6+igATVGvc3a9ihZMdRlbFwst4Y/p0QYGsmLCEn2frbBThcRO
 4BvcmEg1FyAdXZvJcDlelfJqWez5zNBUj/2NA5yO/inUtWK15f/2O+94YDcbBtVjzShf7xyM
 A+2rQLMvcUKnIduMKk8xxXHr3dSZ+hbymxkKFKRkhv++su74Zpv/zhNt/47+MNNX6v3c74kQ
 bFWCTgtLnw46tDsuRTfQgSD4WcRXH8LmRRSGQjF6x/6Xpb1siTks+d2xTeXM87rQ70qQDqu9
 6hlRgfnhyseKTM3/3zZhtR/g6xHrh2hoQd/w5PPb4GOKPV+ZKLdcsgESmdHQ81cSjZOAoK4b
 4sIEuoBIeNVpJTzqlcSsRezAxSnCeXywTFKm3D2x7U33ecvHw7J0gMuAdIAvmnIo9v6L6oST
 fm1wbPUwTnfcf9b2zHw45XIfBA7pvGMWKp9f83Lxkk1FAPFk06QopHqMTOR2OQNqWmb7+xvV
 emyjGMprBt+oiKsxscxkYnFnI0bylTK9SVjwYY1I9K4RVV1YNG6C5RcrTyVOJVvT84kXmpnt
 zo0xKcctp6nYCgF1o4nxxjHZvGFboWF/hDuWuiPLTpli3xrd7Kxihau/US9yuDxStW43VZFo
 CZZktTAqmwA2RPP5sWJRfZw/Ues1ziM2g7T9u1JJ10/m6TcK54k2LEwl5wTvFzeES/xmUX6l
 qiWdl8r+uWu9u/pYa3mq4eCO4NpiAzyKKYjltKlDeglNgUCQXKX9Oa/2bH7+UD0T69Gg/Mrn
 qXDsZ3XId4XqrO7DgJV1Iso9gyxAC280NsCmHkKNFJFdwyDj4juI1zOJff4Deqjg1i2njZk2
 evJMqf8DZrTNnTDkbHhcqhh60NE1gY/0NJS64hWB70fOv7/R0v8uMLCAhI7MAG42+PnB8981
 oMaV2KPGKiZMKbKvFGP/O0vOeqMZJIOuDrnJPYl4/DujWU4mV8bcqmkxpUWZ26jEfh8PkqWf
 2Lggs0dHmcSogo+UOvqhUWeXj5Ue3m9Q6M86yogCIOmCIfDXpqijKaA3Ce9BJ1WZ3pJBkqCE
 Xfyb4mEXewDZzqIIsB9ijwESaShS4g52B2zrAP6xKRoLu3X9CMCrZ/t2td76/XJlR4s6zx6D
 N6T3nmIT2Fzg2MIWyU63a5hrkNm0FuMzLZ3j+RFGtxQ5vNJVx83O4bTweN0Fd78Rh7McNGRR
 Fm7R9WpGysxQc4pztEWekhzA9qsggjY3yqyDb8Yj6aFCYAp/KzBx3TxPN59y3je26khkVYmR
 sxPOHW+iKBm7wbdCN2Br0LMnKGhfqU03SjX9W7Fw3DdkltfVVtVWL/GQGtXS0/Yt9X/6QuWa
 ra0Cqk8dCZFx9SDLKRiddDjy1lLEqSwcO/Can68zj/jTS2DwamBOdKCkwQ12SzcDBJBiAUP5
 TOcMgN4AC69omXYBTgoFFT1Ykqq//Mt4GijQBoSyAeHJ1Zky6Lz4gQc0NmVUfAOxfQpvCk7q
 jN7NEmw1ZTaBonIvBJvKZ1Vesh1+1JbzSTcvg15MIanKvVHj0Qdbh8xkkfgzRRxBa1fnMJso
 H55hBFqJ/e+11VMPyidwYi2OrDTLTzq+wuzbqfNxlzE+NOR57tJ9/ky7Vnu1O2wPmwl9Xgvk
 9xc0n/Go47PEBJXS5X6FEA+6xl9objeJCg7/YLdk3N2Y+GytXfZ1tQlCfFAqF7odspDMK6CC
 A75EtELT8moJuswnlG1bxUCdOlM/a8wNsmierOIwqmudOpnmTuniyxA7uUfmgqp/jB/V/WO8
 pIL2fCe0SOYWj26gFrg+sH7lIZYZC0DS3KlwHusD4pQa6tuOIcTXD33fIvonJMn1sSrBC4Lk
 TzrT0kL08KoZxeIOln03AkKkF8SvWTigyyziTp9jzAuqKObmi3I2eXrMhQdaQspDCFvi0nhJ
 Y+sgpUURk+tOkIMnQGm+F286qxVvqV5IEHMTE0OcyW8fAQAGuOg86GPZcJC8sZilCxNU/mnJ
 32eRKT8pRQyzC7pWWdTjmNeFXniqtDymBp0j3iYJXB4oS/CeM1+8hzY4cTVWf9b2jduqDBQs
 TDMHRD8OtCo+Y/RjJLfqqWkUGnnUJRPcC7txIfGtS2h5GQsDwft1/y0n9TmF0A930qZn5FPX
 D/LsQ26T43lzaW8Psp4c0MuCFK058dhG454m5c9n9lKgCdc2c/TpCtd1zijedxAkbrzdn8MW
 SIGz7u3qED+1UtvI2jIj4P1W3OBw9dwMtyzY2cYwCU4vIhBDKaZ6qABnDMg+APn612LJ6Esx
 HFCmahLijZSmewCtQszwz/IB7kTGRMdJinwj1GS6Nv4qqxLZWGpeLz21UxknNnnAqvRx2MUE
 Hv/ZJomGjd9q8tlN1eZmlj68IL5Y5/9adwJtxubuwjNha5ZJdhi85hCzToiIm/7sXA/nqQeh
 AZtwIr8kYyJMWRr84qmDxQeOjC/NKZxsnn9yK1ZmMiRxYWmGJ5sTy4KUJXfRvWtCDsOtP7jO
 lXGAHgmp3ycA7aaAR6H5RIssSfUC57yfSLyRjFR3ZB4SRKaPkAanA0EQGBwgMsiDg7zjMWzd
 UBk+nYO61S+phYEw7BtMATjF3fRox23Yy04DoeSJlxa42Qgrw/cY8mZ8/42FSZF+Jas6hOAI
 CqXakxBX2QOR1DBDEvpI72to4DJ9eTBQOG5Kp6sKf2H++lZSuvNzomk1ZF+uW+FMMnWeHJlC
 rUt005HFxiVAuz/nDMCA2wSniPJNYuAoQukvzdwpYa5+ejqXwTm4c2ODaFTOJNh4UL+h6DLL
 OOWiCtjTFQQnpoR2X/FzqQe118OmmlvcTeqC7EJqS/KSurZhKZWCxcRby47OtFP6uow2QxEO
 MiTjd2QtPYwlvkuF1JMTkDsgOmsYtEWZX6wPhXLCQfDNbiLIyHK39CiYa64Tu417q0cvBmxt
 DCHVk77a27ayH+2DVb2YLsK03HIWX4W8JuweRtsF2X5GdfvaxnhdcRykSVz27o/wHXDKW8bN
 zF4NUJLtLyZqy1C0ZAdUyRM6GRoKe6clmOX9e7df9wzuOFoHz8yuuZU+nU8xJNK4SsCSPE/y
 06w5pZ+5kqrlOWC0G8tSB1VtjNCn56Gp21nPrjFsIZNUzDI8VheiAfYQwRPrNxjBNr1vqlWw
 dWaj6P/JgBJ9NfM9NcdDczZQCpmGH8mLAavBzPeSgcIH2bD3Y73mEFX1v2fpCT9Rn0StZXm3
 pYDGOczaQ==
IronPort-Data: A9a23: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
 A==
IronPort-HdrOrdr: A9a23:TF+fnqiF5PVHQy09hpbTvcNi+3BQXtkji2hC6mlwRA09TyVXrb
 HNoB1773DJYVkqKRIdcLy7VJVoP0m9yXcF2+cs1N6ZNWGM1VdAR7sC0WKN+UyEJwTOsspm/e
 NbU5EWMrfN5CBB/KLHCGXUKadG/OW6
X-Talos-CUID: 9a23:OTGLy2wjGDEeuSQ3xSN/BgVPIoMKVmOe3k2OMl64Vl5RbrrNV3iprfY=
X-Talos-MUID: 9a23:W3nDTQSeJx8NEbXwRXTFtjBhEN9qs56+S1lOqoc0qcXebypZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,285,1751234400"; 
   d="scan'208";a="240399958"
X-MGA-submission: =?us-ascii?q?MDEqsL75K1FNFT9KT/H3QbMP0oDrHGdFwAQNTN?=
 =?us-ascii?q?8dfsIIsVaHFSNTUc85E69ReuP0lnYgWGCSFnA2842xmo2O7SjnZ562yO?=
 =?us-ascii?q?vgr/AhU8POlfCVwj6Pa3BnjmZVTNaC7Yb+0IHnBqusqwJTtqYHNEHt6o?=
 =?us-ascii?q?mCx9DmWvgy5ldGB3+P1DPf3g=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 13:23:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1758540197; x=1759144997; i=markus.elfring@web.de;
	bh=aGbRtuP0hUze/B2mpfPvy8t/jhHyTV6F9aN6VZtO1fI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ino+n/5IbzxIr7fyjpkd/Sd9r4nyoltXvz6/EmwTaKAIUNj7tLhGs/axcH6SO5n8
	 vm9+HMM4tRvDTmnMjhtXl1do32ZsevhCa8wNdEjEsHNKUyW+2la8KCpGeApDgy+ZB
	 Yx/+Ijk9Uh8uVnwQJDuxPPvBg8eJm0LDRf15Jvud+zZbY9aOEr8sDG/2FoQw1mmRd
	 3FaIQ6vktKi/JE+S1y40rgu7g/+jR/OskDDY/QQ7YUMnyTIdE4wVz62MPjqO/RGx/
	 5bsJhX3XpyhNiHMLffiU4/I+yCjXiKHwhAJWfHi8mvu6hEF7YKMwPdWWyemFEi8ZB
	 1qI6LLwdY7orD3IJYQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.175]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N1u6d-1uKlFk2VIX-00zF8j for
 <cocci@inria.fr>; Mon, 22 Sep 2025 13:23:17 +0200
Message-ID: <c36dca85-bf2b-4e26-a1a5-5c8e31a55911@web.de>
Date: Mon, 22 Sep 2025 13:23:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tpUrdYyITqEutaIxdo+qdnx+9EFk9CCAvTYsOZH/iaF0slWrfQ+
 6MY/wIcqabrr9lCYKsXSdnYwHEplAg40zuXm5U9/ybEIG77Fik8F3Mc8pQq6muA3GSheVS4
 JYMgDazf69dXiE18LheSmh8hPRwiYE1TVlCBKFQbVOIB3cCNeKJO+QUTTVP3ZgTcAXaJGtR
 h8Xcwm9fz0XU1xLlk4gIQ==
UI-OutboundReport: notjunk:1;M01:P0:x6achSbmLnA=;eTS66+1Sp9g7eDWdyykPhgfi5Ph
 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
 nLnfwH2EWyTpz904=
Subject: [cocci] Applying symbolic evaluation/execution together with
 computation tree logic variants?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3030
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/c36dca85-bf2b-4e26-a1a5-5c8e31a55911%40web.de>

Hello,

Source code search approaches (also based on the semantic patch language)
try to detect patterns for improvable implementation details.

* Such searches can specify (by SmPL ellipses for example) that code parts
  should be treated as =E2=80=9Cunknown=E2=80=9D.
  But the corresponding code places can also contain valuable information.

* Search patterns tend to combine items from multiple places.
  Thus limited knowledge is extracted and reused.


I got the impression that some data processing approaches are needed
where higher level properties should be determined from complete implement=
ation details.
It seems that symbolic evaluation/execution is used for this purpose.

Would you find a document (like the following) interesting for further
development considerations accordingly?

Petri Net Based Symbolic Model Checking for Computation Tree Logic of Know=
ledge
by Guanjun Liu and Leifeng He
https://doi.org/10.48550/arXiv.2012.10126

Regards,
Markus
