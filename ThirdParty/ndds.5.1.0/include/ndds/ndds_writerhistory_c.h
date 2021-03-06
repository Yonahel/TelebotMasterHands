/* (c) Copyright, Real-Time Innovations, Inc. 2003-2009. All rights reserved. */
/*
 * @(#)ndds_writerhistory_c.h    generated by: makeheader    Sat Nov 23 02:39:24 2013
 *
 *		built from:	ndds_writerhistory_c.ifc
 */

#ifndef ndds_writerhistory_c_h
#define ndds_writerhistory_c_h


  #ifndef dds_c_infrastructure_h
    #include "dds_c/dds_c_infrastructure.h"
  #endif  
  #ifndef dds_c_domain_h
    #include "dds_c/dds_c_domain.h"
  #endif
  #ifndef writer_history_interface_h
    #include "writer_history/writer_history_interface.h"
  #endif
#ifdef __cplusplus
    extern "C" {
#endif

extern DDSCDllExport DDS_Boolean 
NDDS_WriterHistory_PluginSupport_register_plugin(
    DDS_DomainParticipant* participant_in,
    struct NDDS_WriterHistory_Plugin* wh_plugin_in,
    const char * name_in);

extern DDSCDllExport struct NDDS_WriterHistory_Plugin * 
NDDS_WriterHistory_PluginSupport_lookup_plugin(
    DDS_DomainParticipant* participant_in,
    const char * name_in);


#ifdef __cplusplus
    }	/* extern "C" */
#endif

#endif /* ndds_writerhistory_c_h */
