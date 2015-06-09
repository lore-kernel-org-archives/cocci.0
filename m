From: mcgrof@suse.com (Luis R. Rodriguez)
Date: Tue, 9 Jun 2015 15:18:17 -0700
Subject: [Cocci] [PATCH 0/4] backports: SmPL patch equivalence support
In-Reply-To: <1433549401-17006-1-git-send-email-mcgrof@do-not-panic.com>
References: <1433549401-17006-1-git-send-email-mcgrof@do-not-panic.com>
Message-ID: <CAB=NE6XptbAs-bqBaySAGk8Wyut0NYw4C+HOtfP+VOkm-tSLmQ@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, Jun 5, 2015 at 5:09 PM, Luis R. Rodriguez
<mcgrof@do-not-panic.com> wrote:
> Luis R. Rodriguez (4):
>   patches: remove bt_sock_stream_recvmsg() and bt_sock_recvmsg() from
>     ifdefs
>   patches: change 0054-struct-proto_ops-sig backport strategy
>   gentree.py: add SmPL patch equivalence proof support
>   patches: provide 0054-struct-proto_ops-sig SmPL patch replacement

FYI - dropped the gentree.py patch for SmPL proof support and pushed the rest.

 Luis
