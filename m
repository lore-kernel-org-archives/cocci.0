Return-Path: <SRS0=vM8z=PO=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2FAC433FE
	for <cocci@archiver.kernel.org>; Tue, 26 Oct 2021 21:54:16 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7647160F9B
	for <cocci@archiver.kernel.org>; Tue, 26 Oct 2021 21:54:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7647160F9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
X-IronPort-AV: E=Sophos;i="5.87,184,1631570400"; 
   d="scan'208";a="626575"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Oct 2021 23:54:14 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 920A4E001D; Tue, 26 Oct 2021 23:54:13 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 0C0C4E001C
	for <cocci@sympa.inria.fr>; Tue, 26 Oct 2021 23:54:12 +0200 (CEST)
Authentication-Results: mail2-smtp-roc.national.inria.fr; spf=None smtp.pra=mansourmoufid@gmail.com; spf=Pass smtp.mailfrom=mansourmoufid@gmail.com; spf=None smtp.helo=postmaster@mail-ed1-f44.google.com
IronPort-PHdr: =?us-ascii?q?A9a23=3AyskACRKPHqeeeIsdrtmcuG5mWUAX0o4c3iYr45Y?=
 =?us-ascii?q?qw4hDbr6kt8y7ehCFvbM31w+CBN6Go9t/yMPu+5j6XmIB5ZvT+FsjS7drEyE/t?=
 =?us-ascii?q?MMNggY7C9SEA0CoZNTjbig9AdgQHAQ9pyLzPkdaAtvxaEPPqXOu8zESBg//NQ1?=
 =?us-ascii?q?oLejpB4Lelcu62/6u95HJfQlFijmwbbxvIBi4rQjaq9Ubj5ZlJqst0BXCv2FGe?=
 =?us-ascii?q?/5RxWNmJFKTmwjz68Kt95N98Cpepuws+ddYXar1Y6o3Q7pYDC87M28u/83kqQP?=
 =?us-ascii?q?DTQqU6XQCVGgdjwdFDBLE7BH+WZfxrzf6u+9g0ySUIcH6UbY5Uimk4qx2ShHnl?=
 =?us-ascii?q?T0HOiY2/2/XhMJ+j79Vrgy9qBFk347YfJuYOOZicq/Bf94XQ3dKUMZLVyxGB4O?=
 =?us-ascii?q?xd4wBAPAHPeZDqIn9ukEOpga5CwmrGePvxD5IiWLr1qA91uQuCwfG3BcnH9ITq?=
 =?us-ascii?q?nTUqdL1NLocUeC00abF1jrDb/ZM1jf87IjEaAwuofaJXb9pd8fa1EYgGR/fgFq?=
 =?us-ascii?q?KtYzlIy2a1v4Ls2WD8uZtWuaihmw6pg9+vjWi28gihIbIi48U1F3K+jt1zoYpK?=
 =?us-ascii?q?NGmVUJ2Y8KoHIdUuiyaNYZ4QsIvT3xptSokxbAKpZi2dzUJxpQ/3xPTdeCLfoy?=
 =?us-ascii?q?S7h/gVOudOyl0iG5mdb6liBu//k6twfDmWMauylZFtC9Fn8HMtn8T0xzT7dCKS?=
 =?us-ascii?q?v5n8Ueg3TaDzh7c5fxZLUwtm6rWJJEszqQ/lpoUtkTDESv2l1vsgKCKcUUk//C?=
 =?us-ascii?q?k6+XhYrr4up+RL5F4hh36P6g0mcGyAf40PhYSU2WY4+ix27Lu8VX8QLpQj/02l?=
 =?us-ascii?q?qfZsIrdJcQevqO5BhVa0oA46xa4EjemytEYnX4aLFJLeRKIkpPkO17LIP/iDPe?=
 =?us-ascii?q?/h06gnytsx/DDJrHhGInCLmDfkLf9erZw81JTyA0vwt9D5pJZEaoBIfL2Wk/pr?=
 =?us-ascii?q?tPUFB45Mwquw+bmEtpxzI0eWXjcSpOeZajVulSJzuMpOeiFIoEP6xjnLP1wwvf?=
 =?us-ascii?q?olngkgxc4erSn3JdfPHWxGO9hPl+cZmfig9spHmIDvw54R+vv3g7RGQVPbmq/C?=
 =?us-ascii?q?vpvrgowD5irWN+rrmGFhbWA2GK2EsQTaDwaTF+LFnjsesOPXPJeMEp6zedulzU?=
 =?us-ascii?q?FUf6qTIpzjHlGUSf1zrNmKqzf/ShK7fre?=
IronPort-Data: =?us-ascii?q?A9a23=3Apk05RKzuGN4Mdg8BOhl6t+dWxyrEfRIJ4+MujC/?=
 =?us-ascii?q?XYbTApDx21jNSzmpLW2yFPfffM2Whfdgka4y/oUIDuZeBndNgOVdlrnsFo1Bi+?=
 =?us-ascii?q?ZOUX4zBRqvTF3rPdZObFBoPA/3z27AsFehsJpPnjkrrYueJQUVUj/nSH+OkUrC?=
 =?us-ascii?q?cYUideCc9IMsfoUI78wIGqtUw6TSJK1vlVeLa+6UzCnf9s9JHGj58B5a4lf9al?=
 =?us-ascii?q?K+aVAX0EbAJTasjUFf2zxH5BX+ETE27ByOQroJ8RoZWSwtfpYxV8F81/z91Yj+?=
 =?us-ascii?q?kurPyc0lPT7KLeAbS1jxZXK+thhUErSs3uko5HKBEOAEH1nPTx4A3lIklWZ+YE?=
 =?us-ascii?q?W/FOoXJkeIGVARCFiZjM6xK0LDCKHm798eUyiUqdlOymaszUx1e0Yowo74rWwm?=
 =?us-ascii?q?i78cwIzcGZRGrnPOz2Lv9S+92h81lItODAW+1kmU4mGufUuJ/FMiFG7GQsIceh?=
 =?us-ascii?q?mZh39QVSK6YOt5GPBNxSD/FRzFPHnYeLq4kuNmpo22mK2gD7AvNscLb+EDWxQ1?=
 =?us-ascii?q?1lbXhaZ/bJoDMSsJSkUKV4GnB+gzE7tghHIT34VK4HriE34cjXB8XWb7+0JW9/?=
 =?us-ascii?q?/9uxVCfnykdVEFQWly8rv20zEW5Xrqz7mR8FjUG9cAPGI6DF7ERnCFUZFaLuxc?=
 =?us-ascii?q?dX5xbFOhSBMSl1P/P+wjAboQbZmcpVTHl3fPagRQl01aIm5XiAjkHXHi9IZ6C3?=
 =?us-ascii?q?u/8kA5e8hT54YPPieHogOfFDxTeTFkPsy/y?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A4KxjZqO3nPLb5cBcTqajsMiBIKoaSvp037BL?=
 =?us-ascii?q?7TESdfU7SKGlfqyV88jztiWE6wr5MUtI8bvrBEDqex3hHPBOjbX5RY3DYOCcgg?=
 =?us-ascii?q?qVEL0=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0CkAgDDd3hhfyzQVdFaHgEBCxIMQIQug?=
 =?us-ascii?q?SE7MYRHjmuNMIEDhgOKKoFoCwEDAQ1BBAEBh1MCHQcBBDQTAQIEFQEBBQEBAQI?=
 =?us-ascii?q?BAwMEARMBAQ0LEAg4JoVoDYI1IoQEER0BGx4DEhAPAiYCJAERAQUBV4UkAQMvn?=
 =?us-ascii?q?3mCH4EEPYsygRUFF4EBggkGhEgKGSgNZgOBVwIHEn4qhDaBRxNBTIcgHIFJRIE?=
 =?us-ascii?q?VNoMyaxoBgyVngkuCZQSPFZUHrEZdgl8FgTQLgjCFQpVCMqcdlgygcyCFAhAjE?=
 =?us-ascii?q?oFDgX0zGiOBAYI4URkPjiAMCwuDUIp6KDA4AgYLAQEDCZJvAQE?=
X-IPAS-Result: =?us-ascii?q?A0CkAgDDd3hhfyzQVdFaHgEBCxIMQIQugSE7MYRHjmuNMIE?=
 =?us-ascii?q?DhgOKKoFoCwEDAQ1BBAEBh1MCHQcBBDQTAQIEFQEBBQEBAQIBAwMEARMBAQ0LE?=
 =?us-ascii?q?Ag4JoVoDYI1IoQEER0BGx4DEhAPAiYCJAERAQUBV4UkAQMvn3mCH4EEPYsygRU?=
 =?us-ascii?q?FF4EBggkGhEgKGSgNZgOBVwIHEn4qhDaBRxNBTIcgHIFJRIEVNoMyaxoBgyVng?=
 =?us-ascii?q?kuCZQSPFZUHrEZdgl8FgTQLgjCFQpVCMqcdlgygcyCFAhAjEoFDgX0zGiOBAYI?=
 =?us-ascii?q?4URkPjiAMCwuDUIp6KDA4AgYLAQEDCZJvAQE?=
X-IronPort-AV: E=Sophos;i="5.87,184,1631570400"; 
   d="scan'208";a="626574"
X-MGA-submission: =?us-ascii?q?MDGsK6ACCzBvnktjTIL9ZXdOCM1jc4oC39MnqR?=
 =?us-ascii?q?hqKDSyJHGVWcwS3YBY8Ma00Aez4wNkE/z41ZBrQi8kddT5uohTxi3WDB?=
 =?us-ascii?q?I00NdNGpUiFBhfXPnc7drnAkhKK2CqPTFQdOR1SJNgCi+/JiTUnjzAEX?=
 =?us-ascii?q?Amv1ecRiUT9hHwaZNqoLFj4g=3D=3D?=
Received: from mail-ed1-f44.google.com ([209.85.208.44])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/AES256-GCM-SHA384; 26 Oct 2021 23:54:11 +0200
Received: by mail-ed1-f44.google.com with SMTP id s1so2235813edd.3
        for <cocci@inria.fr>; Tue, 26 Oct 2021 14:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=nS2y2+OJVi/XVxBxbZ/rGdcVEL/dpDlFw8KKM2vAzRQ=;
        b=fWoOViY2J/RT6c62VvJ6aQqHpbxej4ZAaN7n/btx5IZFr8pqvFm9vcdUyVWoDxX1KQ
         czqjd7BEYBgjzRs3Eo1tOGAQ73LouRHBVDbIJlZuLr0r2gfPxSJIi2dHWr6v+zPOpSjl
         1uc6o5S7ixD8s9XfJ2f7bhGUJZNuIiOus2pAOyc1YmpQ5JU9+0B679zuefKTKn93Bm/e
         QKvVcn687gXlhh2I1tbFDkc+z2qmuCSjTV1kpvfHbChVJZ58NmkjaM0tOTtrPHyaDfji
         VCCLnI0TUI1ojBr/TtwBA0MHs9sreuj50LrlJJCUIU01Yb5n+p3XBqQk53YMVjV/zUo6
         l6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=nS2y2+OJVi/XVxBxbZ/rGdcVEL/dpDlFw8KKM2vAzRQ=;
        b=eryDgksbJxkyTLU1sgf2YfNLWjU+ipyMMCcZm7EEO0PuPgNqnPdGTGE1oOaeitb1G6
         bId2srAhysbcKEgFNK0jcQTcEXyjL7Cw7mbT3fM5EloasMzPupq75IgjFZhy7IkYprfy
         moxT6RAabfy/dhAYOnQ7y1VBDwWXV0hpcvfZN4HGAWe2qDZl9l6Ny1o6DIVUSE/4s7k4
         wnKePZJlk7Zgsv/Dht7PCyGXn77LS2Ac5Mp4LDWmmT5NrxvoNJJxtbF5OmxEKqUJ/Gz2
         EYJrRja1gij3L5uHGeErKKLsTbQUP0C2P0Z90HKZ+uD8J/zZyqtB7T5GnOnDYteSti86
         H6bg==
X-Gm-Message-State: AOAM531jqQvFutzbveYm0mKrsDmOnSbpe3LdIhRqnFq44e7/MwV8OKKC
	HuzpbZc9qJc4/Xbb9BJzxFAo3wjwYXY49ddR8xBhtaba9A3KNg==
X-Google-Smtp-Source: ABdhPJz/0pq9/z6OY5+Jskjn1sla2B2G9cotiYN45QEth9giv0B45nChLUn7ZuI+mzJNY/xghRwZduKhVPoVuuVTH14=
X-Received: by 2002:aa7:c0c5:: with SMTP id j5mr5944990edp.194.1635285251001;
 Tue, 26 Oct 2021 14:54:11 -0700 (PDT)
MIME-Version: 1.0
From: Mansour Moufid <mansourmoufid@gmail.com>
Date: Tue, 26 Oct 2021 17:54:00 -0400
Message-ID: <CALogXGULuKk=g58WyH4hBXeRr=epbnJ_n7pHeCbuoq_Q7h28-w@mail.gmail.com>
To: cocci@inria.fr
Content-Type: text/plain; charset="UTF-8"
Subject: [cocci] Feature request: print status messages to the terminal
Reply-To: Mansour Moufid <mansourmoufid@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 40
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-10/CALogXGULuKk%3Dg58WyH4hBXeRr%3DepbnJ_n7pHeCbuoq_Q7h28-w%40mail.gmail.com>

Hello,

This is just a small thing, but at the moment spatch prints such
messages to stderr:

    $ spatch x.cocci --dir linux-5.14.5 2>errors.txt
    $ cat errors.txt
    HANDLING: linux-5.14.5/arch/alpha/boot/bootp.c
         (ONCE) already tagged but only removed, so safe
    diff =
    HANDLING: linux-5.14.5/arch/alpha/boot/bootpz.c
    diff =
    HANDLING: linux-5.14.5/arch/alpha/boot/main.c
    diff =
    ...

It would be nice if these lines were printed directly to the terminal.
That way, they would be visible, but not in stdout or stderr.

I use --very-quiet, but I do want to see these messages, just not in stderr.

Unfortunately I don't know OCaml, but here is how to use ctermid to
get a stream to the terminal:

    #include <assert.h>
    #include <stddef.h>
    #include <stdio.h> /* ctermid */
    #include <string.h>
    int main(void)
    {
        char *tty = ctermid(NULL);
        assert(tty != NULL && strlen(tty) > 0);
        FILE *f = fopen(tty, "w");
        if (f == NULL)
            perror(NULL);
        fprintf(f, "ctermid() == %s\n", tty);
        return 0;
    }

All the best.
