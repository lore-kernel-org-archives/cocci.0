From: eric@regit.org (Eric Leblond)
Date: Tue, 10 Dec 2013 00:31:50 +0100
Subject: [Cocci] Control flow and ... expression
Message-ID: <1386631910.5788.34.camel@ice-age2.regit.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

I'm trying to match when a expression is allocated via SCMalloc and only
reused next for a Realloc.

@realloc@
position p2;
expression x;
identifier func =~ "SCMalloc";
@@

x = func(...)
... when != x
x at p2 = SCRealloc(...)

@script:python@
p1 << realloc.p2;
@@
print "Realloc@%s:%s." % (p1[0].file, p1[0].line)

It is matching if I've got something like:

ssl_state->curr_connp->trec = SCMalloc( ssl_state->curr_connp->trec_len );
ssl_state->curr_connp->trec_len = ssl_state->curr_connp->trec_len + 2 * input_len + 1;
ssl_state->curr_connp->trec = SCRealloc( ssl_state->curr_connp->trec, 2 );

But it does not match on the following code:

static int SSLv3ParseHandshakeType(SSLState *ssl_state, uint8_t *input,
        uint32_t input_len)
{
    switch (ssl_state->curr_connp->handshake_type) {
        case SSLV3_HS_CERTIFICATE:
            if (ssl_state->curr_connp->trec == NULL) {
                ssl_state->curr_connp->trec_len = 2;
                ssl_state->curr_connp->trec = SCMalloc( ssl_state->curr_connp->trec_len );
            }
            if (ssl_state->curr_connp->trec_pos + input_len >= ssl_state->curr_connp->trec_len) {
                ssl_state->curr_connp->trec_len = 2 * input_len + 1;
                ssl_state->curr_connp->trec = SCRealloc( ssl_state->curr_connp->trec, 2 );
            }
            if (unlikely(ssl_state->curr_connp->trec == NULL)) {
                return -1;
            }
    }
}

I've read that "..." is matching anything in the control-flow but in
this case it is possible that both paths are taken. So in my
understanding this should match.

What am I missing ?

I'm using spatch version 1.0.0-rc19 with Python support and with PCRE
support (debian sid package).

PS: it seems that http://cocci.ekstranet.diku.dk/wiki/ linked as the
wiki is currently down.

BR,
-- 
Eric Leblond <eric@regit.org>
