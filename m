Return-Path: <SRS0=o+tk=PN=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60ABCC433F5
	for <cocci@archiver.kernel.org>; Mon, 25 Oct 2021 17:06:28 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88AD960F70
	for <cocci@archiver.kernel.org>; Mon, 25 Oct 2021 17:06:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 88AD960F70
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=do-not-panic.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
IronPort-Data: =?us-ascii?q?A9a23=3AN7KGZKkXQf9SSz/S8JTZ1gHo5gyXJ0RdPkR7XQ2?=
 =?us-ascii?q?eYbTBsI5bp2EAy2UYUWHQP6yON2L2edh0PYuwoR4Fv5GByNYwGVNv+CA2RRqmi?=
 =?us-ascii?q?+KVXIXDdh+Y0wC6d5CYEho/t63yUjRxRSwNZie0SiyFb/6x8hGQ6YnSHuClUba?=
 =?us-ascii?q?eZ3grLeNZYHxJZSxLyrdRbrFA0YDR7zOl4bsekuWHULOX82Yc3lE8t8pvnChSU?=
 =?us-ascii?q?MHa41v0iLCRicdj5zcyn1FNZH4WyDrYw3HQGuG4FcbiLwrPIS3Qw4/Xw/stIov?=
 =?us-ascii?q?NfrfTaVwPWreUPA6Ui3MQVbLKbhpq/3ZilPdgcqNCMwEO1W3hc9NZkb2hsbS7T?=
 =?us-ascii?q?gwiP+jLh+IQSTFZFTt/NOtI4tcrJFDj6ZTJnx2un3zEhq8G4FsNFYYf8e12KWh?=
 =?us-ascii?q?U/vwZNj0XKBOOneS7xPS8UOYErs4iN9L6Mo03tXRpzDWfBvEjKbjIRKjM6Nlw0?=
 =?us-ascii?q?zI5h8QIFvHbD+IVYDwpblLfYhlLO14SE7oxme6pgj/0dDgwgF6cu6s7+G/VwAJ?=
 =?us-ascii?q?+1JDiNdPUfpqBQsA9tkqV4HnB4nbwRBodLtGZ1TuD2n2pj+7L2yj8Xeo6H6al8?=
 =?us-ascii?q?vp7qFKUwWMXBVsdUl7TifO0jEOyWtFDA0wZ+ywj67I1/0+wJvH2Wxq/u1aGvhU?=
 =?us-ascii?q?YXN1LVeY97WmlxqPS4gudQGwJXDVIbtsOsM4wTCYtkFiTkLvBDjx1saaJTmqds?=
 =?us-ascii?q?L2ToDO3JiERIWIYTSsFSwEE/5/op4Rbs/5lZr6PC4atlNr5XDXx2CyHtzVn1/M?=
 =?us-ascii?q?Si9QK3uO15zj6b/uXjsChZmYICs//BApJNj9EWbM=3D?=
X-IronPort-AV: E=Sophos;i="5.87,181,1631570400"; 
   d="scan'208";a="400288"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Oct 2021 19:06:25 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 99C99E001B; Mon, 25 Oct 2021 19:06:25 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 595B9E0018
	for <cocci@sympa.inria.fr>; Mon, 25 Oct 2021 19:06:21 +0200 (CEST)
Authentication-Results: mail3-smtp-sop.national.inria.fr; spf=None smtp.pra=mcgrof@do-not-panic.com; spf=None smtp.mailfrom=mcgrof@do-not-panic.com; spf=None smtp.helo=postmaster@mail-qv1-f48.google.com
IronPort-PHdr: =?us-ascii?q?A9a23=3A8IIgrBXts2fY63j4WCK/dD0pgjDV8KxKVTF92vM?=
 =?us-ascii?q?cY1JmTK2v8tzYMVDF4r011RmVB92duqsP1rWempujcFRI2YyGvnEGfc4EfD4+o?=
 =?us-ascii?q?uJSoTYdBtWYA1bwNv/gYn9yNs1DUFh44yPzahANS47xaFLIv3K98yMZFAnhOgp?=
 =?us-ascii?q?pPOT1HZPZg9iq2+yo9JDffRlEiCC5bL9vIxm7rQfcvdQKjIV/Lao81gHHqWZSd?=
 =?us-ascii?q?eRMwmNoK1OTnxLi6cq14ZVu7Sdete8/+sBZSan1cLg2QrJeDDQ9LmA6/9brugX?=
 =?us-ascii?q?ZTQuO/XQTTGMbmQdVDgff7RH6WpDxsjbmtud4xSKXM9H6QawyVD+/9KpgVgPmh?=
 =?us-ascii?q?zkbOD446GHXi9J/jKRHoBK6uhdzx5fYbJyJOPZie6/Qe84RS2hcUcZLTyFODY2?=
 =?us-ascii?q?8YIkPAeQPPuhWspfzqEcVoBuiGQWhHv/jxiNUinL026AxzuQvERvB3AwlB98At?=
 =?us-ascii?q?mnUrNTuNKwPT+21zLPHzTDYYPxIwzf97JLHchEnofqRWr9wdNbeyUY1FwPCgFW?=
 =?us-ascii?q?dspHqPzSM2uQLtGib8/NsVfq1hG4hqgF+viKjydsrionMn48YzE3P+iplzogvP?=
 =?us-ascii?q?9K4VFJ7bsC+EJtWryyWKot7T8A8Tm12tis3y6MLtYOlcSUFyZkq2RzSZv2JfoS?=
 =?us-ascii?q?U4B/uSemfLzl3inxqd7+ygxW//FWgxODyUsS50VhEoyxYmdfPrnAAzwLf5tSDR?=
 =?us-ascii?q?/dn/Uqs2SyD2x7O5uxAO0w5mqnWJ4Y/zrIskpcfq0fOEy/slEnokaObcl8o9+i?=
 =?us-ascii?q?25+nhf77ovIWTN5VuhQH7KqkumtKwAeA/MgUWWmiU4+W81Ln68U3gXrVGk+Q6k?=
 =?us-ascii?q?qfWvZ3ZP8gbqam5Awha0oYn9RmzFSup0NMdnXUfLVJFfgyIj5TxNl3QPPz1Ce2?=
 =?us-ascii?q?zjlesnTtx2fzKI7nsDo/CI3XAiLvheKxy609YyAo919Bf4JdUB6kEIP3vVU/xr?=
 =?us-ascii?q?tvYDhEiPgOpxObrEdN91oQCWW6WGq+WKqXSsV6U6e41P+aMY4oVtC7nK/c5//7?=
 =?us-ascii?q?ukWM5mVgFcKa12psYdGy3HvV9LkWCYXvsh88BHn0Qsgo/SuzqklyCXiRJa3a8R?=
 =?us-ascii?q?aJvrg08XaC7CYbKDqSkn7WF2G/vHIBSZ2kADlmTGHPsX4SCQfYFLiyIdJxPiDs?=
 =?us-ascii?q?BAJy8SpRp/hGnsQX30b5uL+ycrigTuojk2vB54KjVkg137TVyDs/b2GaIGTIn1?=
 =?us-ascii?q?lgUTiM7ifgs6Xd2zU2OhO0h26Qw/Tl76/QMVAAmcIbVye1xTdv1X1CZFj9oYFO?=
 =?us-ascii?q?vQ9HjGC9oC9xtk5kBZEFyH9jkhRfGjXLC61A9m7vOApsot7rV2Xn6Yc16ziSev?=
 =?us-ascii?q?JQ=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AvWtFNqPmmgC0h8BcTjqjsMiBIKoaSvp037BZ?=
 =?us-ascii?q?7TEOdfU1SL3kqynApoVi6faZskd3ZJhCo6H7BEDjewKmyXcd2+B4VtrMMniDhI?=
 =?us-ascii?q?axFu1fBODZskTd8ljFh5FgPMlbAs5D4IKZNykese/KpC2RM/MB5/fCzYbAv5a8?=
 =?us-ascii?q?vhVQpHlRGt1dxjY8MB+SFglIRBJbH/MCdaa01458vjKlPUsWddigQkMZV/Xevb?=
 =?us-ascii?q?Tw9K4OviRtOyIa?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0A0AgASaxphfzDbVdFagQmFUmuER4kEh?=
 =?us-ascii?q?kVaAQEBBowvhEaCCx2LNANUCwEDAQsBAUEEAQGEYQKCawIdBgY0EwECBBUBAQU?=
 =?us-ascii?q?BAQECAQMDBAETAQENCxAIOCaFaA2CNSkBg2QCAQMSER0BATcBDwsLDwIJHQICI?=
 =?us-ascii?q?hIBBQEcBhMihTEmmwiBBD2LMoExgQGCBwEBBogCCQkBCH4qhw2CUYQVJxx9gRC?=
 =?us-ascii?q?BS4JvPodbgmSoYJ0bgzKeUiuDUwERkWSRLJgvon4CCgcGECOBVIF9cBU7MQaCM?=
 =?us-ascii?q?lAZDpISin4hMgI2AgYLAQEDCYl1AQE?=
X-IPAS-Result: =?us-ascii?q?A0A0AgASaxphfzDbVdFagQmFUmuER4kEhkVaAQEBBowvhEa?=
 =?us-ascii?q?CCx2LNANUCwEDAQsBAUEEAQGEYQKCawIdBgY0EwECBBUBAQUBAQECAQMDBAETA?=
 =?us-ascii?q?QENCxAIOCaFaA2CNSkBg2QCAQMSER0BATcBDwsLDwIJHQICIhIBBQEcBhMihTE?=
 =?us-ascii?q?mmwiBBD2LMoExgQGCBwEBBogCCQkBCH4qhw2CUYQVJxx9gRCBS4JvPodbgmSoY?=
 =?us-ascii?q?J0bgzKeUiuDUwERkWSRLJgvon4CCgcGECOBVIF9cBU7MQaCMlAZDpISin4hMgI?=
 =?us-ascii?q?2AgYLAQEDCYl1AQE?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="397322117"
X-MGA-submission: =?us-ascii?q?MDFREo0YvHuzbKW+778oFO0HbYT77zHWiS0ISx?=
 =?us-ascii?q?h/uPEeyLTRWYK+4UGqDgdKJiBtIPqMARgOOVz4Zfx79ClC5uxdWEDXmD?=
 =?us-ascii?q?+qm9+FuRbw5lskHDbBCBdVCAyrd+Cnu2pRcryvtiucBRZ0gCT+5boACO?=
 =?us-ascii?q?EliXNxsy3FOxVLWm3rDjM4+g=3D=3D?=
Received: from mail-qv1-f48.google.com ([209.85.219.48])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2021 19:06:19 +0200
Received: by mail-qv1-f48.google.com with SMTP id kd16so2209735qvb.0
        for <cocci@inria.fr>; Mon, 25 Oct 2021 10:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=do-not-panic-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GEb6OCV/meZ3qzeNt+5KNW40f1lAyUtMsMWRhcGrcOs=;
        b=ROCND4Rrq3ERDpMlxkDUvJYbkghYlm/tr8lRGB44vQ9uYCsCqTj0N+i+BotqxD8vFb
         m7Vg45HDeZs+dYG6X6F4LOEbEiRRr8G6hxaP4gNzPkIAyhGTD8ehy/Wkoc2WJgM9S28d
         AXJkRM8XpVhEPhq8/PuIDrd41k1MuT4W3D/pnKsTFCJ2Pz8soXWebjw0OjSNpjp7qQxq
         CeeOw+9AEvwnz8xIQ5vHk1UhouhdYlnmvWhymvy7uVUd0A0OsnJ8mv7dayEeD/lVIHXb
         LsMdDXb4hFPb5gVpbrsGv1N9miXS59xZClwGVYhkDOlRpMMtOpMU7+78b9SuPJe58KQy
         47ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GEb6OCV/meZ3qzeNt+5KNW40f1lAyUtMsMWRhcGrcOs=;
        b=Sm8tBvsTWWwi9xBBBrm0hGNlaIeMbYx/1XRpwnuXCHN7/MG5+FgJahsZFGae3f5KBd
         1PFDBEKLSdcMx6fX+4tk3Q6jW8947sDaPxzHT+ipPYU0B5c59XrW3GIM9DWatJlwC0wP
         6O2je7Yy81F0Sg8Upj4YWMijcuxqLkwtwC+YcvAhvhOmR2itqieBcS3D+Zlb39njpXQS
         AR/F/c0dbT+Cl3ZWfDUxAY9S7rhCjZPiHqTuCy+8l9M1QgsbGL22TA+V+J7P1MuzbTIo
         pfCp/oy17neIIU+ooIPxJJlCICXw3H8KeeKs8Z2s8BE220jgyGRKlM3cgvMyQ5GiY2lx
         k31Q==
X-Gm-Message-State: AOAM533D+Lh0qW+jntiYmfdWWzEbguZgLxqE2jXsF0cMe5edNdaGuMJW
	6JMdyRMxevBokx+E4zTZ4k2KHw==
X-Google-Smtp-Source: ABdhPJwz9apiT7c8mYLs5PmtMKVoQCcFMbiVKyqTbc/k1GLNb9lYrnmjeZG+YuvkMlwbAXJgB6TUhg==
X-Received: by 2002:a05:6214:18cb:: with SMTP id cy11mr16943754qvb.46.1635181577671;
        Mon, 25 Oct 2021 10:06:17 -0700 (PDT)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com. [209.85.219.52])
        by smtp.gmail.com with ESMTPSA id l12sm8824095qtq.57.2021.10.25.10.06.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 10:06:17 -0700 (PDT)
Received: by mail-qv1-f52.google.com with SMTP id kd16so2209698qvb.0;
        Mon, 25 Oct 2021 10:06:17 -0700 (PDT)
X-Received: by 2002:a05:6214:5085:: with SMTP id kk5mr17550416qvb.12.1635181577058;
 Mon, 25 Oct 2021 10:06:17 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2110231908290.21613@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2110231908290.21613@hadrien>
From: Luis Chamberlain <mcgrof@do-not-panic.com>
Date: Mon, 25 Oct 2021 10:06:05 -0700
X-Gmail-Original-Message-ID: <CAB=NE6Wk3=iRrR_U7PBpkF6=JzUtcPHf4wZ4jkArQ59GzhWhpg@mail.gmail.com>
Message-ID: <CAB=NE6Wk3=iRrR_U7PBpkF6=JzUtcPHf4wZ4jkArQ59GzhWhpg@mail.gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Joe Perches <joe@perches.com>, cocci@inria.fr, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kees Cook <kees@outflux.net>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [cocci] [PATCH v2] coccinelle: update Coccinelle entry
Reply-To: Luis Chamberlain <mcgrof@do-not-panic.com>
X-Loop: cocci@inria.fr
X-Sequence: 35
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-10/CAB%3DNE6Wk3%3DiRrR_U7PBpkF6%3DJzUtcPHf4wZ4jkArQ59GzhWhpg%40mail.gmail.com>

On Sat, Oct 23, 2021 at 10:10 AM Julia Lawall <julia.lawall@inria.fr> wrote:

> -L:     cocci@systeme.lip6.fr (moderated for non-subscribers)
> +L:     cocci@inria.fr (moderated for non-subscribers)

BTW if one was subscribed to the old list, does the subscription move
over to the new one? And do posts to the old list go to the new one?

  Luis
