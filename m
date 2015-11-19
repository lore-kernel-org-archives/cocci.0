From: mcgrof@do-not-panic.com (Luis R. Rodriguez)
Date: Thu, 19 Nov 2015 15:22:14 -0800
Subject: [Cocci] [PATCH 2/9] Use gnutls_priority_set_direct() to deprecate
	gnutls_*_set()
In-Reply-To: <1447975341-32070-1-git-send-email-mcgrof@do-not-panic.com>
References: <1447975341-32070-1-git-send-email-mcgrof@do-not-panic.com>
Message-ID: <1447975341-32070-3-git-send-email-mcgrof@do-not-panic.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

From: "Luis R. Rodriguez" <mcgrof@suse.com>

Using deprecate gnutls_*_set() triggers a failure to compile
with gnutls30-3.4.4, used on OpenSUSE factory:

../libqemu_common.a(vnc.o): In function `vnc_start_tls':
~/devel/xen/tools/qemu-xen-traditional-dir/vnc.c:2164: undefined reference to `gnutls_kx_set_priority'
~/devel/xen/tools/qemu-xen-traditional-dir/vnc.c:2171: undefined reference to `gnutls_certificate_type_set_priority'
~/devel/xen/tools/qemu-xen-traditional-dir/vnc.c:2178: undefined reference to `gnutls_protocol_set_priority'

This compilation issue can be fixed by using the new routine
gnutls_priority_set_direct() which replaces the deprecated calls
which also simplifies the code considerably.

The following Coccinelle rule expresses the change in a general
grammar form, this could be used should the code be rebased, or
to do the transformation in other projects using the same gnutls
library.

@ vars @
identifier kx_x509, kx_anon, cert_type_priority, protocol_priority;
declarer name NEED_X509_AUTH;
@@

-int cert_type_priority[] = { GNUTLS_CRT_X509, 0 };
-int protocol_priority[]= { GNUTLS_TLS1_1, GNUTLS_TLS1_0, GNUTLS_SSL3, 0 };
-int kx_anon[] = { GNUTLS_KX_ANON_DH, 0};
-int kx_x509[] = { GNUTLS_KX_DHE_DSS, GNUTLS_KX_RSA, GNUTLS_KX_DHE_RSA, GNUTLS_KX_SRP, 0};

@ calls_kx_set_priority @
identifier vars.kx_x509, vars.kx_anon;
expression need_x509;
struct VncState *vs;
@@

-if (gnutls_kx_set_priority(vs->tls_session, need_x509 ? kx_x509 : kx_anon) < 0) {
-	gnutls_deinit(vs->tls_session);
-	vs->tls_session = NULL;
-	vnc_client_error(vs);
-	return -1;
-}

@ calls_certificate_type_set_priority depends on calls_kx_set_priority @
identifier vars.cert_type_priority;
struct VncState *calls_kx_set_priority.vs;
@@
-if (gnutls_certificate_type_set_priority(vs->tls_session, cert_type_priority) < 0) {
-	gnutls_deinit(vs->tls_session);
-	vs->tls_session = NULL;
-	vnc_client_error(vs);
-	return -1;
-}

@ calls_protocol_set_priority depends on calls_certificate_type_set_priority @
identifier vars.protocol_priority;
struct VncState *calls_kx_set_priority.vs;
expression calls_kx_set_priority.need_x509;
@@

-if (gnutls_protocol_set_priority(vs->tls_session, protocol_priority) < 0) {
-	gnutls_deinit(vs->tls_session);
-	vs->tls_session = NULL;
-	vnc_client_error(vs);
-	return -1;
-}
+if (gnutls_priority_set_direct(vs->tls_session, need_x509 ? "NORMAL" : "NORMAL:+ANON-DH", NULL) < 0) {
+	gnutls_deinit(vs->tls_session);
+	vs->tls_session = NULL;
+	vnc_client_error(vs);
+	return -1;
+}

Generated-by: Coccinelle SmPL
Cc: cocci at systeme.lip6.fr
Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
---
 vnc.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/vnc.c b/vnc.c
index 7629dfa18645..32c604084a5b 100644
--- a/vnc.c
+++ b/vnc.c
@@ -2137,11 +2137,6 @@ static void vnc_handshake_io(void *opaque) {
 
 
 static int vnc_start_tls(struct VncState *vs) {
-    static const int cert_type_priority[] = { GNUTLS_CRT_X509, 0 };
-    static const int protocol_priority[]= { GNUTLS_TLS1_1, GNUTLS_TLS1_0, GNUTLS_SSL3, 0 };
-    static const int kx_anon[] = {GNUTLS_KX_ANON_DH, 0};
-    static const int kx_x509[] = {GNUTLS_KX_DHE_DSS, GNUTLS_KX_RSA, GNUTLS_KX_DHE_RSA, GNUTLS_KX_SRP, 0};
-
     VNC_DEBUG("Do TLS setup\n");
     if (vnc_tls_initialize() < 0) {
 	VNC_DEBUG("Failed to init TLS\n");
@@ -2161,21 +2156,7 @@ static int vnc_start_tls(struct VncState *vs) {
 	    return -1;
 	}
 
-	if (gnutls_kx_set_priority(vs->tls_session, NEED_X509_AUTH(vs) ? kx_x509 : kx_anon) < 0) {
-	    gnutls_deinit(vs->tls_session);
-	    vs->tls_session = NULL;
-	    vnc_client_error(vs);
-	    return -1;
-	}
-
-	if (gnutls_certificate_type_set_priority(vs->tls_session, cert_type_priority) < 0) {
-	    gnutls_deinit(vs->tls_session);
-	    vs->tls_session = NULL;
-	    vnc_client_error(vs);
-	    return -1;
-	}
-
-	if (gnutls_protocol_set_priority(vs->tls_session, protocol_priority) < 0) {
+	if (gnutls_priority_set_direct(vs->tls_session, NEED_X509_AUTH(vs) ? "NORMAL" : "NORMAL:+ANON-DH", NULL) < 0) {
 	    gnutls_deinit(vs->tls_session);
 	    vs->tls_session = NULL;
 	    vnc_client_error(vs);
-- 
2.6.2
