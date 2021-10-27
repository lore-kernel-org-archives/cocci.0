Return-Path: <SRS0=/5U0=PP=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA35C433EF
	for <cocci@archiver.kernel.org>; Wed, 27 Oct 2021 15:44:50 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E2E961039
	for <cocci@archiver.kernel.org>; Wed, 27 Oct 2021 15:44:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1E2E961039
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
IronPort-Data: =?us-ascii?q?A9a23=3AC9TGEakJYKS4DwNf8RRqdyTo5gyXJ0RdPkR7XQ2?=
 =?us-ascii?q?eYbTBsI5bpzAGxzNKWTyBPvveMTHxKt0jPYrlpEMEusWBzoQxHQtt+CA2RRqmi?=
 =?us-ascii?q?+KVXIXDdh+Y0wC6d5CYEho/t63yUjRxRSwNZie0SiyFb/6x8hGQ6YnSHuClUba?=
 =?us-ascii?q?eZXgrLeNZYHxJZSxLyrdRbrFA0YDR7zOl4bsekuWHULOX82Yc3lE8t8pvnChSU?=
 =?us-ascii?q?MHa41v0iLCRicdj5zcyn1FNZH4WyDrYw3HQGuG4FcbiLwrPIS3Qw4/Xw/stIov?=
 =?us-ascii?q?NfrfTaVwPWreUPA6Ui3MQVbLKbhpq/3ZilPdgcqNCMwEO1W3hc9NZkb2hsbS7T?=
 =?us-ascii?q?gwiP+jLh+IQSTFZFTt/NOtI4tcrJFDg4JDLnheun3zEhq8G4FsNFYYf8e12KWh?=
 =?us-ascii?q?U/vwZNj0XKBOOneS7xPS8UOYErs4iN9L6Mo03tXRpzDWfBvEjKbjIRKjM6Nlw0?=
 =?us-ascii?q?zI5h8QIFvHbD+IVYDwpblLfYhlLO14SE7oxme6pgj/0dDgwgF6cu6s7+G/VwAJ?=
 =?us-ascii?q?+1JDiNdPUfpqBQsA9tkqV4HnB4nbwRBodLtGZ1TuD2n2pj+7L2yj8Xeo6H6al8?=
 =?us-ascii?q?vp7qFKUwWMXBVsdUl7TifO0jEOyWtFDA0wZ+ywj67I1/0+wJvH2Wxq/u1aGvhU?=
 =?us-ascii?q?YXN1LVeY97WmlxqPS4gudQGwJXDVIbtsOsM4wTCYtkFiTkLvBDjx1saaJTmqds?=
 =?us-ascii?q?L2ToDO3JiERIWIYTSsFSwEE/5/op4Rbs/5lZr6PC4atlNr5XDXx2CyHtzVn1/M?=
 =?us-ascii?q?Si9QK3uO15zj6b/uXjsChZmYICs//BApJNj9EWbM=3D?=
X-IronPort-AV: E=Sophos;i="5.87,187,1631570400"; 
   d="scan'208";a="794092"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Oct 2021 17:44:47 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id F1579E0047; Wed, 27 Oct 2021 17:44:46 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 8CBFBE001C
	for <cocci@sympa.inria.fr>; Wed, 27 Oct 2021 17:44:42 +0200 (CEST)
Authentication-Results: mail3-smtp-sop.national.inria.fr; spf=None smtp.pra=mansourmoufid@gmail.com; spf=Pass smtp.mailfrom=mansourmoufid@gmail.com; spf=None smtp.helo=postmaster@mail-ed1-f44.google.com
IronPort-PHdr: =?us-ascii?q?A9a23=3AIM2woRw9u+gb/dXXCzJdylBlVkEcU1XcAAcZ59I?=
 =?us-ascii?q?dhq5Udez7ptK+ZhSZtKwm0QCBdL6YwsoMs/DRvaHkVD5Iyre6m1dGTqZxUQQYg?=
 =?us-ascii?q?94dhQ0qDZ3NI0T6KPn3c35yR5waBxdq8H6hLEdaBtv1aUHMrX2u9z4SHQj0ORZ?=
 =?us-ascii?q?oKujvFYPekdi72/q29pHObAlFhDiwaq5uIRurqgncqtMYipZ4JKYrzRvJrHpIe?=
 =?us-ascii?q?+BIym5tOFmegRXy6Nqu8ZB66yhftO4v+MBGUaXhYqQ3VqdYAyg8M2A0/8Lkqx/?=
 =?us-ascii?q?ORhaS63QGU2UWlh1IAxXZ7Bz/Q5z8vDf2uvZ71SKHJsD9U6w6Viq+4KdqUB/oi?=
 =?us-ascii?q?TkINzgl8GHMl8d8iLtXrA+9qxBjxoLZZpyeOvhjcaPHZd4VSmRBUcRRWSJPAY2?=
 =?us-ascii?q?ycpUBAPYaMOZEs4XwvUcCoQeiCQSuAu7k1z9GhmXx3a0/y+kvFhvJ3Ao7H9IJr?=
 =?us-ascii?q?XTUtsj+OqAVUeCowqnIzCjMZO5R1Df48ofIdAshofaRXbJqdMrRzlQvFw3Ejlq?=
 =?us-ascii?q?NsoHlMDaV2f4Ms2if9eZvSeWvi2s+pgx3vzOgydsihJPTiYIJ1lDL6z95wIAtK?=
 =?us-ascii?q?NClSkN2f8CoHZpfuSyUK4Z6Xt4vTn91tCsmxbALt5C1cSsIxZkoyBDTd+GLfpS?=
 =?us-ascii?q?V7x/iVuucJTl2inJldb6iiBu/91WrxO7kVsSszlpGsi5InsPPu30NzRDf9NSLR?=
 =?us-ascii?q?/hn8kqu1juC0R3Y5PteLkAuj6XbLoYswr4umZoXtkTOBir2l1/3jK+Sb0kr5PW?=
 =?us-ascii?q?n5/n+brXoqZKROJV4ig75MqQplcy/Bfo3PhISUGic/OSwzLzj/UvnT7VWlvA6j?=
 =?us-ascii?q?LXVvZTAKckYpqO1GRFZ3pog5hqlADqr38wUnXwdI1JEfBKHgZLpO1bLIP3gCPe?=
 =?us-ascii?q?wmVKskCxsx/DbJL3hB5LNLmXNkLfgYLlw8EFcyA8pwtBe45JYEK0OIPX2WkPpr?=
 =?us-ascii?q?tzXEgc5MxCow+bgENh90pkRWGyVDa+dNKPfql6J5uMqI+aXfo8aoizxK/kj5/7?=
 =?us-ascii?q?0jH82g0URfaez3ZEPcnC3AuxmI1mFYXrrmtoODWAKsRYiQ+zrk1CCSj5SZ3OqX?=
 =?us-ascii?q?60m/D07CYSmDZ3CRo+3mrCB0j27TdVqYTVkF1SNGD/MfpqNX/NEPCCPJs5o1Dg?=
 =?us-ascii?q?NSrGlT6cg0wuvvUn00ew0APDT/3g9vJT408Vvr8jUiB8z+XQgCs2byGaQVWRzg?=
 =?us-ascii?q?20JSxc52al+pQp2zVLVgvswuOBRCdEGv6ABaQw9L5OJirUiU7gauyrEd9aNDVu?=
 =?us-ascii?q?qG5CoXW13QdU2zNsDJU16Hof65vgm9yWvCr4R0beMAc5smkoz93f0Lsd5jX3B0?=
 =?us-ascii?q?ft452Q=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ANKvE0aG3ov0xzQtOpLqE18eALOsnbusQ8zAX?=
 =?us-ascii?q?Po5KOGVom62j5riTdZEgvyMc5wxhPU3I9erwWpVoBEmslqKdgrNxAV7BZniDhI?=
 =?us-ascii?q?LAFugLhrcKgQeBJ8SUzJ876U4PSdkZNDQyNzRHZATBjTVQ3+xO/DBPys6Vuds?=
 =?us-ascii?q?=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0DXAQASaxphfyzQVdFagQmFUTsxhEePS?=
 =?us-ascii?q?YInim6BAIVwjAYLAQMBDUEEAQGEYQKCawIdBwEENBMBAgQVAQEFAQEBAgEDAwQ?=
 =?us-ascii?q?BEwEBDQsQCDgmhWgNgjUpAYNkAQEBAxIRHQEbHQEDDAYFCw0CAiYCAiIBEQEFA?=
 =?us-ascii?q?RwGEyKFJAEDL5sIgQQ9izKBFQUXgQGCCAaEbAoZKA1lA4FXAgcSfiqEKoJjhmY?=
 =?us-ascii?q?nHIFJRIFLgm8+axkBhlaCZASHOr49WoJYgTcLgiyaZCuDU6MitkaFABAjEoFCg?=
 =?us-ascii?q?X0zGiOBAYI4UBkOjjeDW4p6KC84AgYLAQEDCYl1AQE?=
X-IPAS-Result: =?us-ascii?q?A0DXAQASaxphfyzQVdFagQmFUTsxhEePSYInim6BAIVwjAY?=
 =?us-ascii?q?LAQMBDUEEAQGEYQKCawIdBwEENBMBAgQVAQEFAQEBAgEDAwQBEwEBDQsQCDgmh?=
 =?us-ascii?q?WgNgjUpAYNkAQEBAxIRHQEbHQEDDAYFCw0CAiYCAiIBEQEFARwGEyKFJAEDL5s?=
 =?us-ascii?q?IgQQ9izKBFQUXgQGCCAaEbAoZKA1lA4FXAgcSfiqEKoJjhmYnHIFJRIFLgm8+a?=
 =?us-ascii?q?xkBhlaCZASHOr49WoJYgTcLgiyaZCuDU6MitkaFABAjEoFCgX0zGiOBAYI4UBk?=
 =?us-ascii?q?OjjeDW4p6KC84AgYLAQEDCYl1AQE?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="397544303"
X-MGA-submission: =?us-ascii?q?MDHAHHD+bu3TP7D3U/MihYoxAn4Z7O1nSoFgzy?=
 =?us-ascii?q?/VEL3ZwS4Ayk0k+QHdg/+4YklJVB2wLJnO3dWDRh2SFXHzWusumMMYW2?=
 =?us-ascii?q?XOJFbO18K3+V1Qio2ESuTKbuM5vTHJO3HVa3b3eODJQdeguzDRSYM3qN?=
 =?us-ascii?q?vCSRzeIUJ86Gyp7BKt6p5zVQ=3D=3D?=
Received: from mail-ed1-f44.google.com ([209.85.208.44])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2021 17:44:41 +0200
Received: by mail-ed1-f44.google.com with SMTP id w12so12233624edd.11;
        Wed, 27 Oct 2021 08:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2/3gGbr3gJPboSmKDYDGBr/B4PahXg5zgLTT8CDykKM=;
        b=JXktmucVET5OeYgBbray+kpYoxdawQ4UhcfORLeKYfY06uJTjtnrMXD9fp8cHR/fIp
         ujpHW2odXsemvogmYVHsOt2npc7cJGR6fNiehwMoEnnn4BWmKONQELOYqntS3Vw5VJqE
         iG2/N38iRwFwyaZXqbq5pjAV+GkNDf7TsRRSFU8UOsFgwC3O7Si4lzSDmDKCkrcqZwY5
         oyxaXZP95P1Cg3l9655q6ZKuXaAdNXtHkVeTO/TSmi8lJkDU+jG+2adqCWtACqLkkHVP
         41bxnJb/G4HzxJraqWhO8zWcuXA7sDlAARt3CUutG7Oar/CjAu1iU5VFXX6LItDymcmJ
         VUaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2/3gGbr3gJPboSmKDYDGBr/B4PahXg5zgLTT8CDykKM=;
        b=UKXVMf/a3p0BD3OzaLsOucA2aubHozzH35eEFLlb70NpZzM6TZv6i/4tVbPzKObsvY
         evsO/3Nv1qfnC1x9V32Sf3/x8pshTYpFEGx5wuENwcY9isW8ogFJp31ptfl0RjQRGX/i
         biN54Gg08keY9nEo4RIHovMpQ17wqANqwsXZQDHWNbZPyZhvb0mOVCBROtuT/Ov03PqH
         Mb27Id/7mCk93j/ckGGMdKGvKsFF9fub6wfzk05RYJcAKPds3oNP/EGjEtMGEQ9nshR1
         JN/SCJt7sJXhrsTZQZINI+jNz5YBqlQUCAI/pxqHX1+37R1mnkCyXUUVopAZLiLuG5Rv
         FJcw==
X-Gm-Message-State: AOAM5315gYmB0tsOjRP9h8gRqL1nzUv0V3yZEPoBcJxtzx3T3u9XvMC0
	39gq0oLy6sxucuJUubXgnNlNEgKVGSdhoeXg6M14g3F6Lxk=
X-Google-Smtp-Source: ABdhPJxnjDtFRtaivHeYW19/yE4uvoNlZ9+DTYCY21MtTUo4lRJHafmKiTyiJZc47Zvvp0X4wc0IH5KuCRb1+7MounA=
X-Received: by 2002:a05:6402:254e:: with SMTP id l14mr45122860edb.199.1635349469835;
 Wed, 27 Oct 2021 08:44:29 -0700 (PDT)
MIME-Version: 1.0
References: <CALogXGULuKk=g58WyH4hBXeRr=epbnJ_n7pHeCbuoq_Q7h28-w@mail.gmail.com>
 <alpine.DEB.2.22.394.2110270723001.2966@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2110270723001.2966@hadrien>
From: Mansour Moufid <mansourmoufid@gmail.com>
Date: Wed, 27 Oct 2021 11:44:19 -0400
Message-ID: <CALogXGWiB_XwOZ5MsQe2qKu8ESDMYfRqTYg24ALZQF=sxkSi5A@mail.gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [cocci] Feature request: print status messages to the terminal
Reply-To: Mansour Moufid <mansourmoufid@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 42
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-10/CALogXGWiB_XwOZ5MsQe2qKu8ESDMYfRqTYg24ALZQF%3DsxkSi5A%40mail.gmail.com>

On Wed, Oct 27, 2021 at 1:24 AM Julia Lawall <julia.lawall@inria.fr> wrote:
>
> I don't want to see these messages.  I at most just want to record them
> for future reference.  So I think we would need a new option to offer this
> behavior.  What would you like it to be called?

I personally like --print-status or --no-status. I've seen other
command line utilities do something like --verbose=1, --verbose=2,
etc. I would be happy with either.
