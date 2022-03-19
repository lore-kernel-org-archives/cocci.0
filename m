Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 358F5C433F5
	for <cocci@archiver.kernel.org>; Sat, 19 Mar 2022 20:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ft9wUILfeA254SkLVrqP6S6Q0FSOCZF6/SFWZOalS1M=;
  b=f5JxnpF9T5+9GYtVRztNc8j5AtvNy6uqVtpoAC9CNtmbr3OUb2d8oE06
   NxBj7LzOWBWGVKnexbccFhSKtr0k7wRNF8F+H9paQk24Rj9RLG4RQ3ySl
   lVLnD2z3u8OS4DxnoFoCESEwxsoclx4N0AHOgYFE1pOR52LWfTg7oM9Al
   4=;
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
X-IronPort-AV: E=Sophos;i="5.90,195,1643670000"; 
   d="scan'208";a="27027005"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Mar 2022 21:33:35 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 761B5E020F; Sat, 19 Mar 2022 21:33:35 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 5A6B4E0069
	for <cocci@sympa.inria.fr>; Sat, 19 Mar 2022 21:33:33 +0100 (CET)
IronPort-SDR: NUo/CAqt0zY3n5O6yoA7T45070VHfAX8yKIGq74klpXKxg7zQfyNUgONKspd0BgEN5IHpx20Mo
 p6m/u0znuaD9u0I9X3U4glON7Bs4NEW9tc6eS5sEchN/2C9q04qyZdeAf6ibLD2dd8e+69bHyS
 m8XyjlXaqGmAYQmH+MzW5Ms2d+qM8nEfORgI7999dXwRhUoijNEGUWJhSihX4g60jBb9Q1sKBT
 IvC+wJUvzuBYTdAwOw/S/X7HuwDgxQ9jmY3huZuOnv4B9oqupmdJ4gyJQ3+Mnwg1Aa/qYMB17z
 kAQzjAF7S2l9VJAR7YXrPVO3
X-IPAS-Result: =?us-ascii?q?A0DCAQCEPTZihw4P49RaHgEBCxIMQIQCgVUrBAtEhFSOc?=
 =?us-ascii?q?4F3MYskhxiMIwsBAwENPgECBAEBhH0KAoQ0Ah0HAQQ0EwECBAEBAQEDAgMBA?=
 =?us-ascii?q?QEBAQEDAQEFAQEBAgEBAgQEARMBAQEMDQkFCAoHDhAFNgZeBmQEgUsEgXQLN?=
 =?us-ascii?q?A2CNSkBg2QBAgIBIx0BAREmAQQLCxoCJgICVwYNCAEBgwCCZQEDDSWtdYExg?=
 =?us-ascii?q?QGCCAEBBoRIHywiUoFbCYEQLI5JJxCBVUSBPAyCdz6ERYMagmWcCsAyNAeCE?=
 =?us-ascii?q?oE6gUEMnhEGFC6DYgGSWg4GkW2WW6cCgXiBfjMaJIM4TgECAQINAQICAwECA?=
 =?us-ascii?q?QIJAQECjh0ZhAyKLEA0OAIGAQoBAQMJhUcBAYoFAQE?=
IronPort-PHdr: A9a23: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
 IGnfEfbNzpItd7Zr5N0Og==
IronPort-Data: A9a23:g+nWyK+KpN+6Ps9uQQ8RDrUDk3iTJUtcMsCJ2f8bNWPcYEJGY0x3m
 jMcWm6Ebq6JMGukeIsjYdnl9R5TvcTcm9M3S1Nq+SBEQiMRo6IpJ/zJdxaqZ3v6wu7rFR88s
 Z1GMrEsCOhuExcwcz/0auCJQUFUjP3OHvylYAL9EngZqTVMEU/Nsjo+3b9h6mJUqYLhWVnV4
 oqj+5a31GKNglaYDEpEs8pvlzs05JweiBtA1rDpTa0jUPf2zhH5PbpHTU2DByOQrrp8QoZWc
 93+IISRpQs1yfuC5uSNyd4XemVSKlLb0JPnZnB+A8BOiTAazsA+PzpS2Pc0MS9qZzu1c99Zl
 99BvJXpFwkSPIbSicIkEBRETw1fMvgTkFPHCSDXXc27ykrbbz3zzv8oAExe0Y8woL8tRzsUq
 rpBdXZUMnhvhMruqF6/YsxlnMc+N4/GOI0Fu3dv5S7UB7AqTPgvRo2QuocCg29o2qiiG97af
 JtGayE1Ti7ORA9iOX4sFJU/nPa30yyXnzpw8Q/J+/NuvQA/1jdZ27/mO9v9Yc2PXcwTn0CCp
 2uA8X6RKhUTK9WbzRKX83emnOaJnCXhWYtUGqfQyxJxqFiU23BVFxAcE1e2yRWktqKgc41VJ
 0Udo3QglqoZ6l2Nd5rwQ0GUgXHR63bwROFsO+E97QiMzI/d7ACYGnUIQ1Z9VTA2iCMlbWFyi
 gTTw7sFERQw4OTFExpx45/J9WvaBMQDEYMVTQMpJefvy/zkpp06hBvSVL6P+4bo0IGsQVkcL
 xiwrCU/gbEai8JO76uy+UKvvt5Bjp3OUxJz+QjdGG6ohu+YWGJHT9z1gbQ4xa8eRGp8crVnl
 CZe8yR5xL5XZaxhbATXHI0w8EiBvp5pygH0j191BIUG/D+w4XOldo04yGggeBg0bJ5ZJ2G5P
 xO7VeZtCHl7bCPCgUhfPNPZNijW5fO/fTgYfq2IP4QVOPCdiifdoXo0PyZ8IFwBYGB1zP1hY
 M7FGSpdJS9UUOxmyia7XeEQzfciyUgDKZD7FfjGI+Cc+ePGPha9EO9bWHPXN7xRxP7a/G39r
 ogOX+PXmk03eLCvOUH/rN9DRXhUdiJTLc6t9KRqmhureVcO9JcJUKOKntvMuuVNw8xoqws/1
 irkCxEClwan2yGvxMfjQikLVY4DlK1X9RoTVRHA937xs5T6SYrwvqoZabUterwrqL5qwfJuE
 asads/GDvkWEmbL/DEUbJ/cqo1+dU331FzUYHf/OGAyL8x6WgjE2t74ZQ+xpiMAOSqAs5dsq
 bOX0A6GE4EIQB5vDZqNZf/2lwGxsHERlfhcRUzNJtUPKkzg/JI0eTP8hLk7LphUexnEwzKb0
 SeQAAsZ/LWc/dVqrYOR3a3d9tWnCepzGEZeDlL317fuOHmI5HenzK9BTP2MI2LXWlT0z6P+N
 +9b+Pfxba8cl1FQvosgSLtmwP5s59broLMGnA1oEG+SNgauDa58ZGaL149Du/QVlLNevAK3X
 GOJ+8VbYOnYZpm6TQRJfAd1PP6e0fw0myXJ6apnKkvN5BhxoOiNX3JUMkTekydaNrZ0bNgoz
 LtzosIQ8ADj2BMmPszf13JR8HmQaGMNWeMru8hCUoPsjwMqzHBEYIDdU3OnvsvQNo8UakR6c
 CWJgKfihqhHwhSQeXQEFU/LgbhXi6MItU0Y11QFPVmIxoHIi/JfMMe9Ktjrotm5Dymr0t6f/
 kBuMFBpY7qD9XFkiaCvmoxq9x5pXHWkFo7ZkjPlV1E1i2G3W2aLIGBV1SOl4hUC62wFFtRE1
 Ojw9YsmOAoGuOnu0yF0VUMNRzkPizBu3lWqpf1L1Php03X3jfQJT0Nuiac1R8PbPP4M
IronPort-HdrOrdr: A9a23:NnrSbar+VJHsSIrz+XGwDJgaV5oPeYIsimQD101hICG9vPbo8/
 xG785rtiMc7wxhIE3I+OrwQZVoJEm2yXcb2+Ys1NuZLW7bUS6TXedfBOjZrQEIeReTygc178
 4JHpSWSueAaGSS5vyb3ODXKadD/DDKysGVbfy19QYXceiGUdAb0+9BYDzrb3Gfz2R9b6YEKA
 ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,195,1643670000"; 
   d="scan'208";a="27027004"
X-MGA-submission: =?us-ascii?q?MDGKpXcOEM7SM5Ka/pxLbiEs+qTurQOfHmMFNf?=
 =?us-ascii?q?sESnAKhbThSu3akPXq4fM3QQVKuKnyi+/zxvQiU6F6dkmj1FFtt5jaMo?=
 =?us-ascii?q?EyOdQeH846Fumf+OhH72qC+69hhZwWfctKy0mriX6yv2zINUFXsfKlvY?=
 =?us-ascii?q?qV8yLexpZDNkyURhwhyQuBIA=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2022 21:33:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1647722012;
	bh=ft9wUILfeA254SkLVrqP6S6Q0FSOCZF6/SFWZOalS1M=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
	b=XLr2Oaiv7vNnth3ZismEd3Lco1DNxPwWXKDJmLZuNYnCN9so55MUu1hoYbqF3PnF8
	 3XF0gzTH9gY6YGkIkFLgurpSrsy9kxrS5tqKAM9KXmS1TPXeSZ97keofeXWda0e0fX
	 SSQRbLAtTyTtyaP5wIOxnZelfWyyQisOtSK0/wNw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.182.172]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MECCP-1nM0jO3dm1-00A7JM; Sat, 19
 Mar 2022 21:33:31 +0100
Message-ID: <c87e6160-1431-8bca-133f-23ed83869046@web.de>
Date: Sat, 19 Mar 2022 21:33:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>
References: <alpine.DEB.2.22.394.2203192112520.3204@hadrien>
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2203192112520.3204@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KDiTpKARca00tdrgpj/xe+C2hbNtr4VCF0Y4IvgMmYMt9FYfjU+
 sQHdzxqR7kxa2sMEQdaSy7nZ3z8uQAbUsw7Pyuoeg3uwccE8pnVrLTMpYG1UMTCXQagMEPU
 BNXgSHTpmjcHs3ao5XgnzFw9lAa5DvZmQDd1/Q0dHXzEd57ims3RwjpfzXWbUSLXwIMrlMa
 AhjVBWIh/ZufLYZzJKZ1g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3RtY47tfGnQ=:V3SOBWO5R976FD3qLwKuai
 UqiMgwqFSbhRUWoNBSuKjC+sm6bJ3xizcYElo+a9tPgev5tlUwn+NarVAPw0S9emabaEyVHnO
 A3j7PvMwMAczRkpYBVq8ikvjRZgpKBndHtliKCldCIerMtHc48UP+2S4HuKZ0PA5x265zzhxp
 9avzmopqXS+LumldK+RuOrNFr5ONXq41B3eluJIoeQUK8pVOqPcpjAqxAwHVVTiAx3xuezvmU
 9a1YvwEkFWBjgmgIbgxvFN3qG9VtARl1xdEYeWPeImzppohOmqUkON2aQt6Wpi3i9A2ad4g4d
 9H//At2RpEx23dCzO8NuOhn8QYfTDa6Ty2QJs+md6oh0e+vOAc4wN52Wsb9qUFZRgYXdxApc4
 vIBgagr/UO9U26SmAG/01C2sltmXt2aIVMvODgXtB48AhKUtOlqkIbWhmRCkkptMNldFTita2
 LvFYiPlL5iZ/UMamdc8wwU1FQLZdzci/pXTMyCx1KBCbqDM2pdvRHeNtqttafKN2erqUWNy/y
 jzL7j4bO2jJWURX+Kc0POs7Ar2Zw5BPV4RWOTfU17XX8YHDoOM9yCtfgGoMxADuxzuwoZht0U
 D1Yl6Jw62bFKPeq/NrX/1qSJNU/sLN82pDd+N7gNwnZrpjwrO+m4qqHR2fnIMiOPxvkCkfcui
 cDGgJnAIKRNpyssx6nP7jHRzrVTZmBnz9Gzzb3wiH3fvCxEKCFdLRMNy9h7Mv8nWknJkiwtfN
 VUWKAxY4Tqj9BaX5Jb5b6GGn2AOQL5eYh6F7yNLAMb7kNRdVAB2JnpySsPRdZ40bY87QwScyQ
 FSI37OcXRFpTJspwDDvE9JzP4MLBE2W3W4rXpwpQitMFh+a7RSrmaUzeib25vgj7yiMgFofL7
 IZCOJ29SHS5X5HYkxRqLjHlKII/l4NxShPNq9Qd4H+kX34Js2GfQcDldKiFa+aiqU5qSWOwjn
 U6+Zrvt7iItLenhvPWOjGeMsv9kU0IGcpFGTJvAu0mu28lq+q4C6CUh1lEHynkOB47BhFLQBn
 wuXIIARy+puS50kxAKKSFL+aT2Zc0lbBRtp2TE4+k5Jp89jSIqAmMwQ/bMj/aJUJkuNYFTKvK
 HkuOQe5QgpqjME=
Subject: Re: [cocci] C++
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 256
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/c87e6160-1431-8bca-133f-23ed83869046%40web.de>


> There have been some improvements in the parsing of class definitions.


How should this terse information help to determine the evolving status fo=
r
better support of the programming language =E2=80=9CC++=E2=80=9D?

Regards,
Markus

