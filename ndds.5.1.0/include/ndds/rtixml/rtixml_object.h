/* (c) Copyright, Real-Time Innovations, Inc. 2003-2009. All rights reserved. */
/*
 * @(#)rtixml_object.h    generated by: makeheader    Sat Nov 23 02:38:13 2013
 *
 *		built from:	object.ifc
 */

#ifndef rtixml_object_h
#define rtixml_object_h


  #include "rtixml/rtixml_dll.h"
  #include "osapi/osapi_type.h"
  #ifdef __cplusplus
      extern "C" {
  #endif


struct RTIXMLExtensionClass;


struct RTIXMLObject;

extern RTIXMLDllExport 
RTIBool RTIXMLObject_initialize(struct RTIXMLObject * self,
                                const struct RTIXMLExtensionClass * extensionClass,
                                const struct RTIXMLObject * parentObject,
                                const char * name,
                                const char * base_name);


extern	RTIXMLDllExport void RTIXMLObject_finalize(struct RTIXMLObject * self);


extern	RTIXMLDllExport struct RTIXMLObject * RTIXMLObject_lookUp(struct RTIXMLObject * self,
                                                          const char * name);


extern	RTIXMLDllExport struct RTIXMLObject * RTIXMLObject_getPrevSibling(struct RTIXMLObject * self);


extern	RTIXMLDllExport struct RTIXMLObject * RTIXMLObject_getNextSibling(struct RTIXMLObject * self);


extern	RTIXMLDllExport struct RTIXMLObject * RTIXMLObject_getFirstChild(struct RTIXMLObject * self);


extern	RTIXMLDllExport int RTIXMLObject_getChildCount(struct RTIXMLObject * self);


extern	RTIXMLDllExport struct RTIXMLObject * RTIXMLObject_getRoot(struct RTIXMLObject * self);


extern	RTIXMLDllExport const char * RTIXMLObject_getTagName(struct RTIXMLObject * self);


extern	RTIXMLDllExport const char * RTIXMLObject_getName(struct RTIXMLObject * self);


extern	RTIXMLDllExport struct RTIXMLObject * RTIXMLObject_getParent(struct RTIXMLObject * self);


extern	RTIXMLDllExport struct RTIXMLObject * RTIXMLObject_getBase(struct RTIXMLObject * self);


extern	RTIXMLDllExport struct RTIXMLExtensionClass * RTIXMLObject_getExtensionClass(struct RTIXMLObject * self);


extern	RTIXMLDllExport const char * RTIXMLObject_getFullyQualifiedName(struct RTIXMLObject * self);

extern RTIXMLDllExport
struct RTIXMLObject * RTIXMLObject_lookUpChild(struct RTIXMLObject * self,
                                               const char * childName);

extern RTIXMLDllExport 
struct RTIXMLObject * RTIXMLObject_getFirstChildWithTag(
                                    struct RTIXMLObject * self,
                                    const char * childTagName);

extern RTIXMLDllExport
struct RTIXMLObject * RTIXMLObject_getNextSiblingWithTag(
                                        struct RTIXMLObject * self,
                                        const char * siblingTagName);

extern RTIXMLDllExport
struct RTIXMLObject * RTIXMLObject_getPrevSiblingWithTag(
                                        struct RTIXMLObject * self,
                                        const char * siblingTagName);


#ifdef __cplusplus
    }	/* extern "C" */
#endif
#include "rtixml/rtixml_object_impl.h"

#endif /* rtixml_object_h */