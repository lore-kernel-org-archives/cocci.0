Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65366D59F52
	for <cocci@archiver.kernel.org>; Wed,  6 Nov 2024 16:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=VSVHsj+bpaoaMgwpAPsQRsXkFUyZZfnyjeId/ivoNik=;
  b=uD2hwFazlVt0FuIhuEkZGhtqpmIhZJ/qrAUAfRByLs1poLQtUuT1WhSk
   eawfznev6/7hU2FhqWzhUvbFz6/bTxqpX4IlQvAKRlVChU8szCvxacggg
   PYkpJO9ndngnR7WmxSVqLGySDFKW+c6ixWZB2TTOGElp3OZqFpLJ6aG8x
   U=;
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
X-IronPort-AV: E=Sophos;i="6.11,263,1725314400"; 
   d="scan'208";a="192575307"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Nov 2024 17:20:32 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D8BF6E0D1D; Wed,  6 Nov 2024 17:20:31 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 4721DE00B7
	for <cocci@sympa.inria.fr>; Wed,  6 Nov 2024 17:20:27 +0100 (CET)
IronPort-SDR: 672b974a_//CWPuTDhulUIzYMKZz4poB8wD/xWVYr858DFQf40qxFYEW
 F9y7AgQVyncccBOyasYzaeP/R4+enKTwMnpk8Vw==
X-IPAS-Result: =?us-ascii?q?A0HfAgBUlitngAwR49RagQmBU4JEYhsGVDMEC0iEVo9Ng?=
 =?us-ascii?q?XSEa48PiHWBVoFAPg8BAwENOQgBAgQBAQMEjzcCHgcBBDAJDgECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQE7Bw4KMYV7DYJbgSxlCTgBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBFgI9Cm0dAQERJzQCJgJzAQGCfQGCLwEDMQcNr3+BM?=
 =?us-ascii?q?oEBggwBAQaCaNdzHywiV4FkAwaBGi6FaoJIGgEFbYoVD4FVRIE8hiICA4Iqg?=
 =?us-ascii?q?w6CaYJMhSIliC1ol3uBTRwDWTIBVRMXCwcFgXoDg1KBOYFRgyBKhRuBBYJKa?=
 =?us-ascii?q?Us6Ag0CNoIkfYJOgSUEBYNvhHCEaYEmHUACAQttPTUJCxsGPZ1VgRpHhGSCM?=
 =?us-ascii?q?QyTM5EVoTc0B4I4gWUFgV4MiQOBJJUuBhMvg3EBk00OBpJ6mHeNf5VPhVSBZ?=
 =?us-ascii?q?zqBXDMaJIM2TwMZD5JOhGG7NUI1OwIHCwEBAwmFRgEBjCqBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:aRXn7q79u6o47Z/b0UwMbwxRtAbDchMFZxGqfqrLsTDasY5as4F+v
 mEaXG+GPayDNjOmKdkiOtzn/R5SuMeEzNJmHgZs+Sk9Zn8b8sCt6faxfh6hZXvKRiHgZBs6t
 JtGMoGowOQcFCK0SsKFa+C5xZVE/fjUAOC6UoYoAwgpLSd8UiAtlBl/rOAwh49skLCRDhiE0
 T/Ii5S31GSNhXgtawr414rZ8Ekz5a2q5mtD1rADTakjUGH2xyF94K03fvnZw0vQGuF8AuO8T
 uDf+7C1lkuxE8AFV7tJOp6iGqE7aua60Tqm0hK6aID+6vR2nRHe545gXBYqhei7vB3S9zx54
 I0lWZVd0m7FNIWU8AgWe0Ew/y2TocSqUVIISJSymZX78qHIT5fj69J8CXwqG6FfxvdMXX8e8
 KUWCWg0cznW0opawJrjIgVtrsEkMdWtI44V/H1tpd3bJax/G9aZGfqMvIAehW1YasNmRZ4yY
 +I8YCBscQ+GThlBIFYRB7ohke3uinSXnzhw8QrN9PBnuzKPpOB3+Jrnav6OWMSkfth6gXebh
 yGX8T7SHA5PYbRzzhLeriL03b+Q9c/hY6oZE7az99ZxkViLzyoSDgcXXB21u5GEZlWWXtVCN
 woL9yBooaVaGFGXosfVeA+9nWKiklkgSuEMDb0/sQ+skpPJylPMboQbdQJpZNsjvc4wYDUl0
 F6Vgt/kbQCDVpXKEhpxEZ/L9luP1TgpEIMUWcMTZScoi+QPTak2iQ/TCMluGui5g7UZ+A0cI
 Rja80DSZJ1K06bnMplXG3iZ31pAQbCXFWYICv3/BD7N0++ATNfNi3aUwVba9+1cC42SU0OMu
 nMJ8+DHs7tWXcrUyHPTELhddF1M2xpjGG2E6bKIN8ZwnwlBB1b+It8KiN2DDBwybJ1UJVcFn
 meJ5V4Mv/e/w0dGnYcsP9LpUJR1pUQRPdXiUPfPJsFDCqWdhyfXlByCkXW4hji3+GB1yf9XE
 c7CLa6EUyxGYYw5lmTeb7lGi9cDmHthrV4/sLihn3xLJ5LENCbNEd/o8TKmMogE0U9ziF6Eo
 ogGbZXSln2ykoTWO0HqzGLaFnhSRVBTOHw8g5U/mjerc1o8SlIyQeTc260gcIFDlqFY3LWAt
 HKkV0MSjBK1iXTbIE/YIjpueZH+b6ZZ9HgbBC0LOUr3+n4BZY300rwTWaFqdpYa9cti78VOc
 d87R+u6DM9icA/3owYmUcGlrahJVgiaugaVDi/0PBk9Z8FBQiLKyP/Ffyzu1nI8MQuqh+QDo
 pmL9ADScbwcTStMUefUb/OOyQuqnH4/wehdYWrBEuNxSm7Nrrd4GnfUteAlBu0xMjDB+2eq7
 BmXChImuuX9mY85393Xj6SirY3yMe9BMmdFPmvct5CaCDL7+ze9/Ip+T+q4RzDRe2fq8qGEZ
 +8O7fXdMuUCrWlaobhHDLdn4qIv1eTB/4YA4FxfI0zKSFC3BpdLAHqMh5BPv5IQ4I5pg1K9X
 0bX9+RKPbmMBtjeL2cQAwgYdcWG6+Afn2jDzPYyIXii3hRNwpi8bRxwMSWP2QtnF5kkFKM+w
 Owkhtwa1BzntDouLeS9r35180aiEyU+dpsJ57AgPZ/Tqws0y1t9T4TWJQ3o7bquNdhdEEkYD
 QWFpajFhr5jlxPOWCdoJ0fswNhyuJUqkzJJxW8kOF6mtIfkhPg2/RsJ6hUxbF1f4Stm2tJJG
 FpAFhNKN4CR2TZ33u5RcnuJCSgYIDG4o2vfk0Aokk/dRGmWDl39FnU3Y7uxzRpI4lBicSh+1
 5DG7mTcCBLBXtz7hwk2Um5b883Td8R7rFD+qZr2Dva+PscIZBT+ifWTfksOkRzsBP0xiGDhp
 eVH+OVRa7XxBRUPop8UWpWr6rANdC+qfGByY+lt3KcsL1HufDuf3TuvKUfoXuhvI/fM01GzC
 u0wB8Zpeim96h2zrWEgNfZRG4N3of8n38pdW7XJIWVdjaCTgAA0u73t9w//plQRffNQregHJ
 LnsKg2ySl6ruSMMmkvmjtV1BW6jUNxVOCz+xL+U9csKJbIiscZtUxoA7ZqpjVqoMS9M3RGdj
 CXcbYD4ks1gzoVNmdP3M6NhXg+bF/L6ZN6qwiuS7etcXIjqCtjcki8osXzlAlhmBqQQUNFJi
 ri9it7780fbtrIQUWqCuZ2+O4RWxMe1Bsx7D9nWKSREoC68R8Pc2RsP1GSmI5hvktkGxM2GR
 RO9WfSgZ+wuRNZR631EWRdwSy9HJfzMUZ7hgieho9CnKBsXi1XHJez6007ZVzhQcytQNqDuD
 gPxhe2V2elZi4ZxHz4BOeBtBs5pAV3kWJZ+TebLixujMjCKjG+B65zYrjhx2QGTXzPAWIz/7
 IneTxfzSAWqteuahJtFuoh1pVsMAGw7neA0eVkH9sVrjyyhSlQLNvkZLY5MH6Q8fvYeD30kT
 GqlgKoe5STBsfBsdBLh/JL8Uw3ZCuFm1hIV4NA21xv8Vst0LNro7HhdGuNI/Hp8PDfupA1iA
 c9L4WX+Z3Bd3bkwLdv+JZWHbSNP2f7QgH4Fkaw4fwoeHD5GaYg3OLdd8MahmMAJ/wwhVKkGG
 ITteV15fQ==
IronPort-HdrOrdr: A9a23:i4j/r6trbpicvHN3iyM2X96I7skDeNV00zEX/kB9WHVpm7+j5q
 eTdZUgpHvJYVkqOE3I9eruBEDEewK4yXcX2/hyAV7BZmjbUQKTRekI0WKh+VDd8kbFnNK1u5
 0NT0EzMqySMbAm4PyV3DWF
X-Talos-CUID: 9a23:lJY7wGxZqUBdpt9AxkbkBgUzCMUYblvxi0vBGBOmWWMwRpzNcEK5rfY=
X-Talos-MUID: 9a23:vmYK4QuThXeUmjT+Hc2npjs4EJxK+4qVFW8SoJYn+JiKbwduJGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,263,1725314400"; 
   d="scan'208";a="100928024"
X-MGA-submission: =?us-ascii?q?MDEdpOXbk6serGl9vuxFRRXaHmtYYJQgazsARz?=
 =?us-ascii?q?XyNC6J12aExaLKaYPLtVEw8fwdpxpPZAU2lqzbVSXyVszf6+k/JXZ1ax?=
 =?us-ascii?q?LwTVlRCuBKzug9dXnahOTrxft0BRBdvlOb76Q6VwQ0OU2CBCbtzh5WMQ?=
 =?us-ascii?q?V4t/l5fqskhulbWgpMaw7OkQ=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 17:20:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1730910025; x=1731514825; i=markus.elfring@web.de;
	bh=VSVHsj+bpaoaMgwpAPsQRsXkFUyZZfnyjeId/ivoNik=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=uJPjvzkk9at61T07mrrgyRDl/rbiqBIeeXVbeWWKQE84rV4naVeOClS6kbCwG48e
	 0I8qxVRHb54WaUr8WKD+M8DKB6RBxMB7iMQgcvMhpbeejrDZxuOpvZq0877hlQv0o
	 kBtHlbBPRRATDKNAYRbTlmTcpWrpk+sKSuKR4fMEWQt/HdUGTR3UscG84x3VfIRjY
	 HABuKfjpeVPUBQE2KJMIKDDgHufHrdEJiNY1HL/pQwDh5t9cvCG6H95F+ZuvpkYvx
	 6cFs3wIGVZO6djyty1EF7maJtCW52qWzXPMhR+EwxJbUFr5291mhVAGW7VapxAUrt
	 4gu67IkkE4FgF+KbqA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N3Gga-1tq8Fv2q0Y-00tWnd for
 <cocci@inria.fr>; Wed, 06 Nov 2024 17:20:25 +0100
Message-ID: <c07553fd-4c04-4f5c-a72e-a71fb1e66c38@web.de>
Date: Wed, 6 Nov 2024 17:20:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Kc5AHUcajH5wQNa/ighEBOCqI6Nf+2UaFYwz7bcHEgaB9IfoD15
 GLFItrla/lXbaZMhsZN4hcu32abeBZ/UgQXOZa9G2IT6FgM4R5jRhU4mBKv+RcSCwQJ/Iug
 Bg4CznbbzygmNheLPgwOoK2piL1XmBjaR3vu3XqUv0m9HUWkWv4VuM9jXk8NbBCDNXswq2h
 2as/uRJiGs5BRoYGtsrBg==
UI-OutboundReport: notjunk:1;M01:P0:63Xr20uoqwQ=;UxxYZTwfG6KN5SKpUEF88Muyzs3
 tEF5C0BxrJfaB7RjdSX+GwdhyhOCnlR1HmMG/oXww1omrXevVjPQb0YfafrrjbVsdweBFTX7O
 cuBGLpqo1+guOW2QyS1i/hmIvaVLKoWni8OADy5HaKZod+HfmBL7pMjKcutgwN7I93O4bDprV
 Z7gB5yutdo3MkPGUwL9q/Kp0E+7G8jRBmdo6rkRhJ5wDVeAZD2t5NLkaPdiYWZ28vm55Hmn5m
 N19QDa3mQXkCqxwQwMNEvhxQNxuBWZ4sdxQcLiKs/ViJzVZZnfrRcIz4cT6uycIAYy07v5Adh
 NPFfy8thMWRAvQba05Xq8iPiFNoGog1o9xmId/e1lecZtog8VAdNBefJGESe/3f4uXTiz4JoH
 tqghf0KEil7uNRTI1H1g27iyzKWy1KpgRdttPkj4BrpY3mMox/Iv+TjyAdjKLwj/rJNQ9Ghw+
 Bn5ubagO82MJGhSSifdbmaN157NiFBl787vuWPcfN5S8r79L2z5DKUQxnFWLyY2XdBkq/tm05
 0BPT/PgpSg2AC58V3lIB9Qf4rsXiSgkzAz0h8JtH/uiDIsNYrpHGnlF5NhV/53JVSL66ghR8v
 kHwOYfMCCfSPYkKwfZfgflYKQtAqZg6A2hcXs8ZfYXWTV0d6KI80tKXyPUcOPz8s6hYKwkq0O
 HbtUaEYPKOEVYuJkbXuwKskrS6JuBLeMfh/92bNTmlKQjx6XJoPYYb40qwA0dcSnZuCk6PFcz
 cloyAAZsxNjZBKwkNH1tBu/2C9XRL7y4mflGT/sRV67MgAXqKbJl4+dEAGGBPfa74b+U72+Hj
 GNZwtqj0ceY7VVDFZozYeh2QHKA5wUXySa9lrc9yIxh9VkLM/iGr9dEzpHYEQIwUceVrd3+KB
 4VnFq6iv0IYkxDtlubtQrNbxCsu+OS4qy/em2OzW6nFF17Sl1MVHGe5/m
Subject: [cocci] Generating parse trees?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1971
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/c07553fd-4c04-4f5c-a72e-a71fb1e66c38%40web.de>

Hello,

How do you think about to improve the collaboration with data processing tools
that can generate parse trees?
https://en.wikipedia.org/wiki/Parse_tree

Will the support grow for selected programming languages?
https://en.wikipedia.org/wiki/Comparison_of_parser_generators

Regards,
Markus
