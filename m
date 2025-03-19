Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B7FC35FFC
	for <cocci@archiver.kernel.org>; Wed, 19 Mar 2025 14:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=k7hjEHi7wNArj7cbKoI5z5vagL68z0y2JFHWZkGptII=;
  b=sMdg37w1p19a0YbaMxPeFaue5BqnDFN3Ie8RKYx7seUJri9vXbmnv53V
   ZKk+VFXJKNLZGSkBqF7JNLNpeNIGbxbNtKXa0NqhPd5wXUWizo4aB5zfH
   4MXeZyIyJbccSSUTMi4iLPGZ6dua2kWanTOn6FHLsD3NGPUdk7A0nfe6l
   0=;
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
X-IronPort-AV: E=Sophos;i="6.14,259,1736809200"; 
   d="scan'208";a="213721190"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Mar 2025 15:06:32 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 95D0CE007A; Wed, 19 Mar 2025 15:06:32 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id B04AAE0261
	for <cocci@sympa.inria.fr>; Wed, 19 Mar 2025 15:06:30 +0100 (CET)
IronPort-SDR: 67dacf66_TSG9NX6iMRYaYKfwkzOFOdk2Ivg2rRmF5RpLwqsg2jaB2Y6
 Aq9WGGICKnakm4wo4dcGfVbZQeZ9vKCentmzBsg==
X-IPAS-Result: =?us-ascii?q?A0GjDgAnztpngAMP49RagQmEF31aMwQLSIRWj1CBdIEFg?=
 =?us-ascii?q?2aPDoh1g1QPAQMBDT0EAQIEAQEDAwGFAIsiAh4HAQQ0EwECBAEBAQEDAgMBA?=
 =?us-ascii?q?QEBAQEQAQEFAQEBAgEBAgQGAQIQAQE7Bw4KMYV7DYJiAYEkgSYBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQINOkYnHQEBESYBN?=
 =?us-ascii?q?AImAnMBAYJ+AYIvAQMxBw2uW4EygQGCDAEBBoFOAQwYdtdzHywiV4FlAwaBG?=
 =?us-ascii?q?i6FbYJJGgEFbYQKhG2BIQ+BVUSBPAuIRoMOgmmCM4RBZ5l4hQCLR4FNHANZL?=
 =?us-ascii?q?AFVExcLBwWBbAOBD4FFeIJEaUk6Ag0CNYIbfIIoagQFg1qEPoRAhVCCEYIFg?=
 =?us-ascii?q?jGFTYE1hGEtUIIWHUACAQttPTcJCxsGPaJFNzU7hVEsgQBflBeyaTQHgjiBZ?=
 =?us-ascii?q?gWBXgyJBYEklTUGEy+DcAGTVQ4Gkn2Yfo4FlVYdhTuBfiOBXDMaJIM2TwMZD?=
 =?us-ascii?q?5IbM4ELs3NCNQsxAgcBCgEBAwmFRgEBilSBSwEB?=
IronPort-PHdr: A9a23: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
 tWdzMobxx9d/tiS8cZOXqA8zeqYPXBnPRe7QFbp
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:wji3jKgXyGROBrWlMhflYnDb7HBQXv0ji2hC6mlwRA09TyX4rb
 HJoB1173/JYVoqOU3I+urvBEDjewK4yXcd2+B4Vt2ftWLdyQ+Vxe9ZnOzf6gylNSm72eJUyL
 t6f7IWMqyTMbG4t6vHyTj9PdIpwNzC1rupi+fYx3IoaQ1xcalv40NYJ2+gYy5LrcV9aabR3a
 Dy2vZ6
X-Talos-CUID: 9a23:xT0x/WPDYkBM7u5DZCZgyBAlOfAZVFLS01zgHhKWFV1ucejA
X-Talos-MUID: =?us-ascii?q?9a23=3ARBiOLA+nTK38+2KzoYw9nCCQf4RkoLavGE8KqNI?=
 =?us-ascii?q?fhfe5ahdwJC2tqjviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,259,1736809200"; 
   d="scan'208";a="112036832"
X-MGA-submission: =?us-ascii?q?MDEZOeyIyEk3adoxgF4WK2aZWexyIs4Os2QaK9?=
 =?us-ascii?q?9/VEhTS/nvavvF/mKJB5l6Gwpnh80sP5/hs0F+yKYgAUNy7wH2/BX6Vl?=
 =?us-ascii?q?8iduA0RgK1btmXqW4BBc/BvhBKM8QaQTAOYAq6wluAZxZYyF96QYGQj+?=
 =?us-ascii?q?UExuQj65zKn21MWRaIyybTcA=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 15:06:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742393188; x=1742997988; i=markus.elfring@web.de;
	bh=k7hjEHi7wNArj7cbKoI5z5vagL68z0y2JFHWZkGptII=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tCOIjTBCkjhHjqFDXENV06ZgkAmLH48HULU+e+W/PsZwcvvlIX5Gvnzp5kzlXFDT
	 3KIPlAg8NsyrKn+OTBc17z/qhkGLNbzJKjQyr9HHZI2Hoyxsk2dW8VuRlF4ARsyk/
	 jobAZ/5zh16GVmlC64s0bJP7utrDorINFpienKc7rWvethw3Z0U2l2B4/3sBoYlYj
	 DtR7SNk6Pw7ZsIMjz+ITvHVzfOhBmgIXqxBUQJlRYwf+jPWcmBPZxSpouCpKgCRa/
	 hFSrdA4L99g30YP9wiJwEPADY63jsMXMM5b9b4yOc59QPvQBUsSlkwdkHBxCWRWOF
	 9+3sN/G01aTPnyMapg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.16]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MKdLM-1tc7ey3C0q-00JHUZ; Wed, 19
 Mar 2025 15:06:28 +0100
Message-ID: <8886034f-43ac-4475-9f16-faa2db8de5de@web.de>
Date: Wed, 19 Mar 2025 15:06:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB
Cc: Victor Gambier <victor.gambier@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OjBD9TJibrdpftSUgq8bRUlTu18+gwTkqlK7gYIXddm17Xzqrvh
 g3k0BnuTXnlGaNA3Y8o/XAlqnw3HkDYdWqfZpGZgrpmwmEQq6dWK1EQ7JzXFd5ii8HmG3nO
 62wfO00JkMrNMNmiEEKclIESIwpdtEh/9xthMx7GH7Ak7Wlqzkxj+/busqFQUL4jGP7O7Hp
 dPNAfpVy7lgk50AQxRAlA==
UI-OutboundReport: notjunk:1;M01:P0:ANPBR8uyfLQ=;uxJ4seu/wJ32txeUfnrpUGB3ONy
 muUXCyZfEWXJrghsMjpEKuGkX7mloWy7vu9LFdUGe4a3iC3NRoMT7UF8+99fc0Lj0T5GhUfIq
 yjpTGh1JqqGMg8TYvkxinN6GbP5DzQrV4TdT8gTuLE5sz6i7qW6FCBNu/bRQOjlR0s+GWc7VS
 lrvhhVMjSYXL3pWN6dIIjVixS4kOvqHT5Mc4+/7bpd/Y2+HFtofczkwOjoua7BTUP9JvzU9DM
 lLrd1xXXJ3KKL0embyOt1UttlO9vFzFeB0zQcwVkuqkSDd59kP2M5g4UpTQkAAI+qeTTKGoEl
 X1IH1E5L6NHRmDm3I63U/9ZBLQxHCEUtGxBIt3mhWcbWEpDg7zf6g9PctUY87NZNHgtzhQXYW
 HScYe+DKltk6VpsYjaiwtf40I8u1+pS/ppCYNQsdelsXv0hAx9bGt2Mlh33H5tiwtsSQkSpP2
 mwR+Fw2IBSJlcNAYd0ZngpEfZhiyJACK/z19R8A6FSbXMrCbc4UniI/wkyglhE4E7XeXIh4I8
 BRwLr0wkUBYD1qnTx0Yg7Kt+soW/iEWwalJKiuNs7BbbMHRdCTCxdmVyu3TThuQGAAfn5o+k9
 t5T961fiWMBhUj3uozyZSnbNp+PC9KBqtaGOqSTyfELzdB4elT/xl0h+Wym7FfBpscKXHCVfu
 IR8OjVZGIIwbQOWQ8UNpfTCCgE8O+VmJb2Iz5Tnk1SqoOYT+S8DDX9GO9UCrmkPO+z+ddvMpg
 1wc2MPhRAO4ZH7ogQPhYyxXbXzo2EAH+hQsNZCNjXIbJuV5eFk4fCMoR8lyZmuNILESzHiKMn
 mG7nhV6S9bBXYVu64LtfIWMj+a30xcqCc+yH0hjwSJq2svBO+9qzPQjVeD4loE2ZRQDiMMP5b
 ZVhBOgJ4bkNbr8I7C8PlHneHfIW0yTr1rRD98x4TJZnGzI7PfR3tl5/WrGKLl0nz7rDi8CASQ
 a6OvWL4X4sbQkIOLZaIyx5Hd+m4EsG61MmumlmhjuBk081l2GtnD52J686JBKPvl1wecbEPdQ
 Id7oRQGDkgErPk8UAhDALKp9dK11JqPKp8QKx5l/jH1XLc2j/oRO+8SRHoyPqdpKB6LtZCzKt
 2BTZAw89Q/xDy1b9C8peWQPUffQ2kX9Kzqej2g9Udv0AyIO9fkackY72d546XHMVPi6ZtJqXg
 hmY2uTRzIwY2SGhNUUd69xZsm9hMoAzP0NO2b3RQO6ekTDaLjxuYWUaS+YGFR67VeGeFA8j/a
 Oz1kuV4kOSpYahpZErl1oP2kTCphx02y1CR6uo3Os/pHwDahT0Ak9ZdMhENo2+7rDJP+bJ3Ov
 D5oMpbTrch+osctv4QoqC+1F78qg4F77sA4FVFcyZ9MsrJJUjbSWcEm7+AaKQ1exwrESA8bas
 +hblJk9Fhxxq6SWkMALbsgcnMfOIBp9WIdTRcUfNiSc/5er/0dy678uMobVsiRGhoq/GyZgLG
 S/JSbn9fidGyrgIljwfYo6mTSi5Nmwr3uNeo3bueyEWKkPvEGXkI5S1ving6UdACjlUVLNQ==
Subject: [cocci] Improving find commands?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2656
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/8886034f-43ac-4475-9f16-faa2db8de5de%40web.de>

Hello,

I noticed also the contribution =E2=80=9Cfix the broken command line argum=
ents for find command=E2=80=9D
(by MA Xutong from 2025-03-12).
https://gitlab.inria.fr/coccinelle/coccinelle/-/commit/67d1b7c071a65f154f9=
4c1193ab2d14f8d1bd3bc

How do you think about to enclose file filters by single quotation charact=
ers
(instead of double quotes)?
https://unix.stackexchange.com/questions/170179/whats-the-difference-betwe=
en-using-single-quotes-or-not-in-find-command

Regards,
Markus
