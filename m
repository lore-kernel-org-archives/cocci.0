Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F0B7D1D887
	for <cocci@archiver.kernel.org>; Thu,  4 Dec 2025 07:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=xqCm484pHl8JNCLw9ZtXCLYmDayROPJ3v8y9yPxl4SA=;
  b=R0ZnjaonR/NB0IdjV2s0frTJpGRoZTNElHU+U2M4btSaSnkcY0INSsFu
   4B9JOWTIcQ9ECy4kiiMW9YboscnDaAQmousH4McLDIVT98V1i0oT98LcX
   yEtB4O6h3xUWgg0rIQBtvMY1Mj6AufkRqFFOXQK8T9iXYBSK8NQhGtr1q
   w=;
X-CSE-ConnectionGUID: kl3qMiDGRqCF3LtR7P6l0A==
X-CSE-MsgGUID: spDqU4wLQcuS68gvseSf1g==
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
X-IronPort-AV: E=Sophos;i="6.20,248,1758578400"; 
   d="scan'208";a="252672184"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Dec 2025 08:54:13 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 63D73E0AF1; Thu,  4 Dec 2025 08:54:13 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 5AC85E00A5
	for <cocci@sympa.inria.fr>; Thu,  4 Dec 2025 08:54:07 +0100 (CET)
X-CSE-ConnectionGUID: fKPWb4f0QiKJpg6ZhzG9GA==
X-CSE-MsgGUID: 09cseoUbS4CfFNYW8Qy5Jw==
IronPort-SDR: 69313e1f_9ehNB2UeiUr6Rb6fs+HshSfvyKmttGqR2c6ZuQoUGvm86c8
 iqt8E7/bvss0EFnS0ohO6HPl4d5BYjeyhyGraOw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0H+BACePTFpg07ASNlaHgEBCxIMQIFFC4JAZSNZMwQLS?=
 =?us-ascii?q?YRVj1OCJIQ7hzyHVYxLAg8BAwENTgECBAEBAwSBTIM0AoxnAh4HAQQzBg4BA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAEBASEZBw47hk8Ng?=
 =?us-ascii?q?mIBgSSBJgEBAQEBAQEBAQEBAR0CR0QBAQECASMdAQERJgEECwsaAiYCAlYGF?=
 =?us-ascii?q?QEBF4JngiMBBhABAw8nB7FxgTKBAYIMAQEG2mEfLCJZgWQJgR0uhW6CZQGKZ?=
 =?us-ascii?q?icPgVVEgTwLgkcxPoRDg1uCaYImgQ6GH4tWh3BSeBwDWSwBVRMXCwcFgSBDA?=
 =?us-ascii?q?4ELI0sFLR2BIyEdFxNgPRdAg0kYBmcPBoERGUkCAgIFAkA6gWgGHAYcEgIDA?=
 =?us-ascii?q?QICOlUMgXcCAgSCFn6CCg+IA4ELBS58JwIBC209NwkLGwY9lRlPg1yCQUajC?=
 =?us-ascii?q?KJ7NAeCOIFngWQMn2wGEy+EBI0ThjsOBpMFmQapQIF+JIFcMxokgzZPAxkPj?=
 =?us-ascii?q?iEZhBq7cUI1PAIHAQoBAQMJhUYBAYxWgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:NdcwhKyscD/awe2PNJp6t+d1wirEfRIJ4+MujC+fZmUNrF6WrkUPn
 WoXDDzSbPyPMGLyKdBxPd+0o0MHsZCAzYM1QQdvqVhgHilAwSbnLYTAfx2oZ0t+DeWaERk5t
 51GAjXkBJppJpMJjk71atANlVEliOfVAOO6ULOZUsxIbVcMYD87jh5+kPIOjIdtgNyoayuAo
 tqaT/f3YTdJ4BYqdDhMg06/gEk35qmr4mtE5gVWic1j5TcyqVFFVPrzGonqdxMUcqEMdsamS
 uDKyq2O/2+x138FFtO/n7/nRVYBS7jUMBLmoiI+t3+K33CuDgRrukoKHKJ0hXV/011lrPgto
 Dl5jqFcfC9yVkH6dEvxZDEDe812FfUuFLYquhFTu+TLp6HNWyOEL/mDkCjalGDXkwp6KTgmy
 BAWFNwCRh6gv928nLzjc+hPpNwscvvrLqxOlVg1mFk1Dd5+KXzCa6DN+MMewzo6wMxDdRrcT
 5BANnwwNlKZMkcJZQd/5JEWxI9EglHaeidbtUnTiK45+WnVwyRu3bKrPNe9ltmiH5gPwBnC/
 z2el4j/KklLP8eSzgePyS6HiMHprByrYZNPNqLto5aGh3XImjxLU01JPbehmtGyjUW1WvpEO
 kkM82wvq7Iz/QqlVLHAswaQpXmZolgDVtAWH+BSBByxJrT87SWhOWJYQGZ4af8ErMBodzw4+
 Q6mtoa8bdBwi4F5X05x4Z+4gFuP1cU9KGgfeWkbQAFD79SLTGAPYvDnH4gL/E2d1IWd9dTML
 9ai8XdWa1I70J9j6klD1Qqb6w9AX7CQJuLP2ukoYo5VxlglNNb+N9PABanz7PFGK53RVVTpg
 UXob/O2tbhUZbnUzHLlaLxUQNmBua3eWBWC2gEHInXU32/0k5JVVdsJuGkmTKqoW+5YEQLUj
 Lj74lMOvccLbSb6N8eaoeuZUqwX8EQpLvy9Pti8UzaESsEZmNavrX8wN32DlXvgilYtmqwZM
 JKWO5TkR3UDBKgtiHL8S+4B2PV5jmoz1EHCd6Ddlh6H6Lu5YGLKaLEnNFDVUPs1wpnZqyro8
 vFeFfCw9TNhbMPEbBPqrLEjdWIxESBjBLTdidBmSeqYEw83REAjE6DwxJ0iSaxEnoNUtLz6w
 VCgaGBlyX7Up37OGSOVYF9NNZLtWpdeqyogHCoOZFyH5VkqUbyN3ow+KaQlWKYBz/Ny68J0Q
 90uWdSyMt4WRhvpoz0iPITA9qp8fxGVtCeyFiuCYglnWaV/RgbMq+TWTiG2+AYgViOI5NYD+
 Zu+3QbmQL0GdQRoLODSTNmNl1qRn3wsqNhebnvyAOt4WRvTqdBxCinLkPUIDdkGKkzDyhukx
 g+mO0okiteXkbAl0uvipP6ilJioIdtcD0ABPmj87JSKDwf40Fen47d9VLevQWiAekLyoL6vd
 MdE/cHaafcnpmtHg6B4MrRszJ892efRmq9n/lxkMUjPPnuWCeJGA3iZ3MNwmLVH6Z1HtCCXB
 E+e2NloFo+YGcHiEVJLGgsBa96H9PALmwv96eY+D1X66RRWopuGcxR2FDudhBNNKIBaNNse/
 t4gn8oN+SmTtwEPMOvavhtL9m+JEGMMY58nur4eHoXvrAghkXNGXrDxFQ7058upR+hXE0x3P
 AKRurXOt45cymXGbXA3M3rHhshZpJYWvSF13E0wHEuIlvXFl80I8kVoqxpvdTtszzJDz+5XE
 UpoPRcsJayxohFZtPIaVGWoQwx8FBmV/3Lq8GQwlUrbclKJU1LcJ2hsKMeP+0Ekq1hnRAZ5x
 43B6mjZUmfNRvrTjw8SQk9ursLxQeNhrjPinN+VJOXbPp0YTwe8vIqQSzspkSb3OeIwm0zNm
 sdy9slSd6DQFHAdso87OaagxJUSTxGOGz0bTdo8p5E2PHzuVwyz/ROsKEmBXNxHCNKX0E2/C
 u1oftluUTbn3gmwjzkrP4w+CJ4qo+wM+/wDZaHOCVMdlrmi8gpSr5Pb8xbhiF8RQ9lBldg3L
 qXTfWmgFlO8qGR1mWiXiuV5IUu9PMc5YTPj0NCP8OkmE4wJtMduexoQ1pq2p3CkDxt1zSmLv
 Q/sZ77k8MI68N5Cx7DTK6RkAxm4DfjRV+7SqQC6jIloXOP1aMzLs1sYl0njMwFoJoAuYtVQl
 4mWkdvJzUjA7acXUWfYpsG7LJN3x/6OBchZDsGmC0Nhv3qyaJe5qV9LsWW1ModAn95h99GqD
 VnwIte5cdkOHcxR3jtJYixZCAwQELnzcrymny6msvCQEVII5GQr9j98GaPBNgm3txPkOqESz
 ifxvOuyoM9VpsJACXfowh2g74BQeDfetWkOLrUddgV0ykG3j1nEtraKed8I92TQEnfdeCrly
 cute/U9HShefInXwdsfv4EaUtj7yppiqbFYQ3/xMOKaR9x34KDq4Ajd3Vg75klorxHP
IronPort-HdrOrdr: A9a23:qIYMBqmtFfR9WhQnt+TOdrqhH+PpDfL43DAbv31ZSRFFG/FwWf
 re+MjzpiWE7Qr5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQyVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK7/oSizPZLz9P+qjlzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-Talos-CUID: 9a23:T9VCHm729z+95Vo/7Nss+m0sJcp5fCXkzVTyO0DmO2Z7Z+y6YArF
X-Talos-MUID: =?us-ascii?q?9a23=3AAUwmagwWFlnTNTQiIjvxnEw0YKuaqPz/A1sAlqg?=
 =?us-ascii?q?MgJWvOwJWCgjNtSXqYJByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,248,1758578400"; 
   d="scan'208";a="252672170"
X-MGA-submission: =?us-ascii?q?MDFmauuaiyq1ZCVfEwGMUfnMHBjPUpU7Gm8+b7?=
 =?us-ascii?q?x5krjR19jY6Zh8Yw6YVByOOogQabBetlFMwsPs3ZgUcfk39Cr/WIlujl?=
 =?us-ascii?q?IqII0Go68vXBq4FNdzGrhmu2/879dCXhS8h2pYcyLgjUUHMW8OaguhGh?=
 =?us-ascii?q?K0zYt9mUO/ZidBXEM7kqsEtw=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 08:54:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1764834846; x=1765439646; i=markus.elfring@web.de;
	bh=xqCm484pHl8JNCLw9ZtXCLYmDayROPJ3v8y9yPxl4SA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=AQB/q0UpjOveHOXa6ofmlTCez0wxpvOhG/s7xQZYl6/Gp66L8kjaPIfUK4Ph/2Yx
	 QejRcE9Ic6TecGIExMcjhuvcQUAG2AGT2IKiWEtXaeQRJeOSVl7zV8jNd2zd1ig0i
	 00EbW6PItIJ9p8ugF+39a5C6hWi7cIK4czSut+940PdWrc1WW0DAnnDh8at/gwj5P
	 cap1JwKAXGcYW2GXv2TgvJ6uIQ2T2LD4LeRnO9JychZFkNebRxb3Ozb7x6QBvjCdk
	 jzcy20DTz3BJCXVz1KbjIwLzFlMYaMZHG50guE4ed9SwPMXA6Ol2+UgC9hb6GV6Xz
	 2xpW0wP/nSjwqrmDXA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.242]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MQxo5-1vfgd84AQ3-00L0Vd; Thu, 04
 Dec 2025 08:54:06 +0100
Message-ID: <1534c930-426e-4939-8fcb-ad4a32c3e23c@web.de>
Date: Thu, 4 Dec 2025 08:54:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Tobias Deiminger <tobias.deiminger@posteo.de>
References: <1b8dad8151ef1409adc8cb24c728907a@posteo.de>
 <9ab63cb6ee4a0354c053f22fb0934317@posteo.de>
Content-Language: en-GB, de-DE
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <9ab63cb6ee4a0354c053f22fb0934317@posteo.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:p104CkMnEY1uc2jVj0B6MfMAwcfoXfeg6IoGNAEJiIET61B8XrZ
 aQA0cpraPuiCp5OW7iwRMIYquu+pblXaBpjr0LYxhTapoArZl9Bz4ZhzsGHrBAKJ3SZnTD6
 9H/AmrdKO2LMto2cTccCtPWvCRubTmDTzrSaDk9VQp2KYB34JZt/bD0HMzTbPSmYvlV50XK
 Eohy9s9oLortDEjk5aWww==
UI-OutboundReport: notjunk:1;M01:P0:+jxkJRoTWQk=;qyqjQZV+MNq6IbpIWTZeVdbJP/4
 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
 SnZksiJYmZY2kGt/k=
Subject: Re: [cocci] Search for the concatenation of meta variable + fixed
 string
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3239
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-12/1534c930-426e-4939-8fcb-ad4a32c3e23c%40web.de>

> Found a workaround using fresh identifier to add an intermediate helper =
construct:

Please reconsider your solution approach once more.


> @device_attr_ro@
> declarer name DEVICE_ATTR_RO;
> typedef __DEVICE_ATTR_RO_T;
> identifier attr_name;
> fresh identifier show_fn_name =3D attr_name ## "_show";
> @@
> =C2=A0 DEVICE_ATTR_RO(attr_name);
> + __DEVICE_ATTR_RO_T attr_name =3D show_fn_name;

Would you really like to modify source code here?

Are you more interested in an =E2=80=9Cordinary=E2=80=9D source code searc=
h?


> Seems to work good enough. If there are cleaner ways, let me know.

I suggest to take another look at algorithmic properties.

Would you need to extract identifiers from selected macro calls?

Regards,
Markus
