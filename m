Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F07CC25B75
	for <cocci@archiver.kernel.org>; Sun, 26 May 2024 16:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=HkaZnmEzcOJk6LYUaZQ6mhN0oNEcrvHRDz4epjy8g4k=;
  b=dQSubdArs6BTCNql/GlLMt4xkbua1GvfmhzFof6uwG/SaILVboIjtf+S
   lsD1YOOOzkrH7ti1USoWqxBKy7t0omymeyeBWlv9sbJgk/xpJxK8Rrw1F
   C0b4C34dnrTTA58tpkm9Nq/4siB3ArTyFdU54iv5Ptxf0ZPlryWWcNGtY
   Y=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.08,190,1712613600"; 
   d="scan'208";a="167473376"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 May 2024 18:34:31 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id AAF20E0AF1; Sun, 26 May 2024 18:34:31 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id C761FE00B7
	for <cocci@sympa.inria.fr>; Sun, 26 May 2024 18:34:29 +0200 (CEST)
IronPort-SDR: 66536495_BNvzKfqnHD/pvKTtJyzVxzDbmeFKztqben2PA0lrXrz2hTA
 nNnnNk0olIpCgnOsmEe+fJsBl/Wa1h4Ln5wxfeg==
X-IPAS-Result: =?us-ascii?q?A0HdBwDNY1NmhwMP49RagQmEE4ECVDMEC0iEVpE9hGuHO?=
 =?us-ascii?q?YdQiHGDFj4PAQMBDUEBAgQBAQMEgguLQgIeBwEENBMBAgQBAQEBAwIDAQEBA?=
 =?us-ascii?q?QEBCAEBBQEBAQIBAQIEBgECEAEBASMXBw4FCyeFdA2CYBiBDoEmAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBFwJHax0BAREnNAImAl8UAQGCfIIwAQMxB7AggTKBAYIMA?=
 =?us-ascii?q?QEGgmfXch8sIleBYwmBGi6IFBoBBWeFEAmEXg+BVUSBPIhRgw6CaYgQAY5Ug?=
 =?us-ascii?q?waCHJErgVEcA1kyAVUTFws+CRYCFgMbFAQwDwkLJioGOQISDAYGBlk0CQQjA?=
 =?us-ascii?q?wgEA0IDIHERAwQaBAsHdYMlBBNEA4E3iXCDO4IghBwIQ4EBg3CBbQ5hiByBd?=
 =?us-ascii?q?IFGgWp7HUACAQttPTUJCxsGPahGgVU2lg+yHDQHgjaBYAWBXQyIfZZLBhMvl?=
 =?us-ascii?q?zkOBpJomGMgoxiFUoF8I4FcMxokT4JnTwMZD446hBTLFUE1OwIHAQoBAQMJh?=
 =?us-ascii?q?UYBAYNagUgBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:mWer4KFEv22apJcApLqEyseALOsnbusQ8zAXPjNKOH9om6uj5q
 eTdZUgpHvJYVMqM03I9uruBEDtewK/yXcX2+cs1NWZMDUO0VHAROxfBODZsljd8kPFltJ16Y
 clVbRiA9vtClVAgd/9+xTQKadZ/DDKysGVbfy19QYKceiGUdAY0+/zZzzwLnFL
X-Talos-CUID: =?us-ascii?q?9a23=3AljUbDGjRcL8L9RLWlUhvxgGKKDJuKUbDkSbcYF6?=
 =?us-ascii?q?DFzw3GbO0WA/PqI9FnJ87?=
X-Talos-MUID: 9a23:YwxQYAWNjd67/6Lq/HzGii1OKuxh2vjtEXIkmKseq82uLjMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.08,190,1712613600"; 
   d="scan'208";a="87994561"
X-MGA-submission: =?us-ascii?q?MDHxuMjZdURWTRSHg8WCWhS8BflgdPs4SG+nfn?=
 =?us-ascii?q?YUxrJCO68xehNUuAsq5EzjhMSiY+Xdr+uO9EbXCZlC/H69+rej9vWqYT?=
 =?us-ascii?q?RI99Yh4W56wxLSqMuNFOYjaFw0ht4/BUd7A/e93zYwqv+Ml/FDOCSBDk?=
 =?us-ascii?q?Ts7nY6agrFwpvk3IExgAfLiQ=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2024 18:34:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716741268; x=1717346068; i=markus.elfring@web.de;
	bh=HkaZnmEzcOJk6LYUaZQ6mhN0oNEcrvHRDz4epjy8g4k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=EGGbFf4lDtn1iL3J8T6FwCyqiIOcmbV79uCQ05Gbq35I6OEjbEg1H2j+HdjUXBfI
	 gOSGMTRFOmWsb2p9lfS2QPqwg/7Uueo7A4oUkQ4g8ga8SNHbXZIjNkZNQVual8t67
	 kAOlKVwM9lUTieueco2bGSy+D8E0fjwvMQwfWGbQvZLVJo9FHxfKH3dA8j/hmlL2m
	 gLo4ixW+IwnWgKcEIu0hpIdumhf39ISqezCGgvIEYrdsnY5Od7G8s5+AX4JXSZqOR
	 QyuJ1AexjPjhGNiYh89A/vVR0vlJNAIaZOuRPIUU+JH/gJwgQ/GeppP0G5T6k6eYL
	 sqDgrzagPgZuhSv1Yw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Ml46y-1swfsN3UcO-00c8iV; Sun, 26
 May 2024 18:34:27 +0200
Message-ID: <7eb9626c-da7b-414d-bf50-da1eed27be31@web.de>
Date: Sun, 26 May 2024 18:34:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr, kernel-janitors@vger.kernel.org
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WenWFZ/QirNitzimPB6U2RpkUo+GsVf2PqRfzThyEmQv9BamDtz
 wYcyMW+vk+FzkEFC+xT7JlGnK7GPRDwbVRsx3AVNG14RfBxuKCrx3Q27tLTx+biyCmmxjIN
 3AYzdW04c6XJCOMkBRE+81QYJFkCo7J3ri6yM889M61nWD1djeE90Gj9kDXU1ydsI44UiUd
 wZLDTPp0KR8RPNtNXL94w==
UI-OutboundReport: notjunk:1;M01:P0:bOaTM5Eqsus=;LIQy42UP4X6VIwsWHxeFawTRug8
 g/JcZ1OGTJIVKNprQZ6giudMXyyMK92fZ4N8Sm+uiZDcIZCrYXEjeAYhg1oe+kMqH0xTZ/4Vt
 MwesNxJbtnpwPgLCGy5rS/CyhBPasEPFHSndV94b6oo+K1I7ElFsWE3I8kNrVbbXwQ0jvzgNX
 O/RRixkKZw4NQssfkqlG+xRKbca/HNPcbzx9dcL6i0bStS1KaqTqh8rLoaT/ib0i+ANhBft/I
 Z4j/1kv0hz5gShVmUhEG1n9oUgUfYEuwbULR8aN8Ue+5kHZELnzi9+pf2TaL/o8HIejKNIaFv
 opjaWYf79PAdVr440DrJFFBRHTZK33W9JYPM8Dbfnjvpzin3xNHs47vhO/i7xnfjCKuRUlStg
 A4Ou8OOG3TlDjw0qY3Yx7fuNb0ADJdWeu6vVj9Wc2bSKzoEV1/e5O/ppHQYNCajxuH/RG0DLF
 722mzkzcXBYctZnFYFK7klm2CqZ2VnnTCw7ahv/sVjxsByKBMhWuTjq2djZ8LGEhq/rOMP1OH
 qxtiAdrua/usfDnLyZRZtpVrdu2mPnmomI7X8Rq/ApIfb1u3bOvZW3CdvrKDjRcK6Tu8pNHbK
 c+f042l6362SyEh7Cu8IwbZ7XH+rsEqrYOkDOGUqiGVxNjsixmkaFEm9m3iPLE6H/mtC1LFxj
 333g++29op8khHUwP3768HJCgwNA7v9sO/QIIO9ioq0uJJLxS8nz34XyOJY8ijVa6XiW1kLa0
 mGm2SQFabva/Y8Fcyqzs7O5ANqT9JNSEQqcnq+5Z6g8dAalO4vTeOIMcJ2c0LNkPz2syUrpZf
 muYEK85gWuRp5Asmwj6fetYXuKeC4IfKwwcMwn2yjYTYc=
Subject: [cocci] Increasing usage of mutex guards (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1755
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/7eb9626c-da7b-414d-bf50-da1eed27be31%40web.de>

Hello,

I constructed another small script variant for the semantic patch language=
.


@replacement disable decl_init@
expression action, e, value;
expression list el;
identifier rc;
@@
-int rc;
 ... when !=3D rc =3D value
     when any
-mutex_lock
+guard(mutex)
           (&e);
-rc =3D action(el);
-mutex_unlock(&e);
 return
-       rc
+       action(el)
 ;


I tried this SmPL script example out on source code from the software
=E2=80=9CLinux next-20240523=E2=80=9D.
425 source files were found where some function implementations could be a=
djusted
also according to the application of mutual exclusion.


Will it become helpful to offer further SmPL script variants which can be =
used
together with the tool =E2=80=9Ccoccicheck=E2=80=9D?

Regards,
Markus
