<?xml version="1.0"?>

<!-- 
/* $Id: typePublisher.cs.xsl,v 1.4 2012/04/23 16:44:18 fernando Exp $
 
   (c) Copyright, Real-Time Innovations, Inc. 2005.  All rights reserved.
   No duplications, whole or partial, manual or electronic, may be made
   without prior written permission.  Any such copies, or
   revisions thereof, must display this notice unaltered.
   This code contains trade secrets of Real-Time Innovations, Inc.
 
Modification history:
- - - - - - - - - - -
10ac,10sep09,fcs Fixed bug 13100
10x,15may09,fcs Fixed bug 12950
10z,18feb09,fcs Replaced NDDS_QOS_PROFILES with USER_QOS_PROFILES
10z,12feb09,fcs Fixed bug 12684
10x,12feb09,fcs Fixed set_verbosity_by_category call
10x,21oct08,fcs QoS Profiles support
10x,21oct08,fcs Fixed generated code with modules
10x,04aug08,ao  corrected grammar
10x,26jun08,rbw Reflected error handling API change
10x,18jun08,rbw Reflected error handling API change
10v,02may08,eys constants rename in .NET
10v,25mar08,rbw Fixed file name
10v,19mar08,rbw Reflected API change
10a,14mar08,rbw Made code more OO; removed unsupported database stuff
10a,06mar08,rbw Fixed *_QOS_DEFAULT
10s,04mar08,rbw Fixed lots of compile errors
10s,29feb08,rbw Fixed WriteLine syntax errors
10s,28feb08,rbw Fixed many compile errors
10s,13feb08,rbw Created
-->


<!DOCTYPE xsl:stylesheet [
<!ENTITY nl "&#xa;">                <!--   new line  -->
<!ENTITY indent "    ">             <!-- indentation -->
]>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
				xmlns:xalan="http://xml.apache.org/xalan"
				version="1.0">

<xsl:include href="typeCommon.cppcli.xsl"/>
<xsl:param name="useQosProfile"/>

<xsl:output method="text"/>

<!-- ===================================================================== -->
<!-- Document Root                                                         -->
<!-- ===================================================================== -->

<xsl:template match="/">
    <xsl:text>using System;&nl;</xsl:text>
    <xsl:text>using System.Collections.Generic;&nl;</xsl:text>
    <xsl:text>using System.Text;&nl;</xsl:text>

    <xsl:apply-templates/>
</xsl:template>

<!-- ===================================================================== -->
<!-- Struct Declarations                                                   -->
<!-- ===================================================================== -->

<xsl:template match="struct">
    <xsl:variable name="fullyQualifiedStructNameC">
        <xsl:for-each select="./ancestor::module">
            <xsl:value-of select="@name"/>
            <xsl:text>.</xsl:text>        
        </xsl:for-each>
        <xsl:value-of select="@name"/>
    </xsl:variable>    

    <xsl:variable name="replacementMap">
        <map nativeType="{@name}"
             nativeTypeC="{$fullyQualifiedStructNameC}"
             IDLFileBaseName="{$idlFileBaseName}"
             archName="{$archName}"
             modifyPubData="{$modifyPubData}" coreProduct="{$coreProduct}"/>
    </xsl:variable>

    <xsl:variable name="lastTopLevel">
        <xsl:call-template name="isLastLessDeepTopLevelType">
            <xsl:with-param name="typeNode" select="."/>
        </xsl:call-template>        
    </xsl:variable>
        
    <xsl:if test="$lastTopLevel = 'yes'">
        <xsl:call-template name="replace-string-from-map">
            <xsl:with-param name="replacementParamsMap"
	                    select="xalan:nodeset($replacementMap)/node()"/>        
            <!-- The template for Support of each -->
            <xsl:with-param name="inputString">
                <xsl:text><![CDATA[/* %%IDLFileBaseName%%_publisher.cs

   A publication of data of type %%nativeType%%

   This file is derived from code automatically generated by the rtiddsgen 
   command:

   rtiddsgen -language C# -example <arch> %%IDLFileBaseName%%.idl

   Example publication of type %%nativeType%% automatically generated by 
   'rtiddsgen'. To test them follow these steps:

   (1) Compile this file and the example subscription.

   (2) Start the subscription with the command
       objs\<arch>\%%IDLFileBaseName%%_subscriber <domain_id> <sample_count>
                
   (3) Start the publication with the command
       objs\<arch>\%%IDLFileBaseName%%_publisher <domain_id> <sample_count>

   (4) [Optional] Specify the list of discovery initial peers and 
       multicast receive addresses via an environment variable or a file 
       (in the current working directory) called NDDS_DISCOVERY_PEERS. 

   You can run any number of publishers and subscribers programs, and can 
   add and remove them dynamically from the domain.


   Example:

       To run the example application on domain <domain_id>:

       bin\<Debug|Release>\%%IDLFileBaseName%%_publisher <domain_id> <sample_count>
       bin\<Debug|Release>\%%IDLFileBaseName%%_subscriber <domain_id> <sample_count>

       
modification history
------------ -------       
*/

public class %%nativeType%%Publisher {

    public static void Main(string[] args) {

        // --- Get domain ID --- //
        int domain_id = 0;
        if (args.Length >= 1) {
            domain_id = Int32.Parse(args[0]);
        }

        // --- Get max loop count; 0 means infinite loop  --- //
        int sample_count = 0;
        if (args.Length >= 2) {
            sample_count = Int32.Parse(args[1]);
        }

        /* Uncomment this to turn on additional logging
        NDDS.ConfigLogger.get_instance().set_verbosity_by_category(
            NDDS.LogCategory.NDDS_CONFIG_LOG_CATEGORY_API, 
            NDDS.LogVerbosity.NDDS_CONFIG_LOG_VERBOSITY_STATUS_ALL);
        */
    
        // --- Run --- //
        try {
            %%nativeType%%Publisher.publish(
                domain_id, sample_count);
        }
        catch(DDS.Exception)
        {
            Console.WriteLine("error in publisher");
        }
    }

    static void publish(int domain_id, int sample_count) {

        // --- Create participant --- //
]]></xsl:text>
    <xsl:if test="$useQosProfile = 'no'">
        /* To customize participant QoS, use 
           DDS.DomainParticipantFactory.get_instance().
               get_default_participant_qos() */
    </xsl:if>
    <xsl:if test="$useQosProfile = 'yes'">
        /* To customize participant QoS, use 
           the configuration file USER_QOS_PROFILES.xml */
    </xsl:if>
<xsl:text><![CDATA[    DDS.DomainParticipant participant =
            DDS.DomainParticipantFactory.get_instance().create_participant(
                domain_id,
                DDS.DomainParticipantFactory.PARTICIPANT_QOS_DEFAULT, 
                null /* listener */,
                DDS.StatusMask.STATUS_MASK_NONE);
        if (participant == null) {
            shutdown(participant);
            throw new ApplicationException("create_participant error");
        }

        // --- Create publisher --- //
]]></xsl:text>
    <xsl:if test="$useQosProfile = 'no'">
        /* To customize publisher QoS, use
           participant.get_default_publisher_qos() */
    </xsl:if>
    <xsl:if test="$useQosProfile = 'yes'">
        /* To customize publisher QoS, use 
           the configuration file USER_QOS_PROFILES.xml */
    </xsl:if>
<xsl:text><![CDATA[    DDS.Publisher publisher = participant.create_publisher(
        DDS.DomainParticipant.PUBLISHER_QOS_DEFAULT,
        null /* listener */,
        DDS.StatusMask.STATUS_MASK_NONE);
        if (publisher == null) {
            shutdown(participant);
            throw new ApplicationException("create_publisher error");
        }

        // --- Create topic --- //

        /* Register type before creating topic */
        System.String type_name = %%nativeType%%TypeSupport.get_type_name();
        try {
            %%nativeType%%TypeSupport.register_type(
                participant, type_name);
        }
        catch(DDS.Exception e) {
            Console.WriteLine("register_type error {0}", e);
            shutdown(participant);
            throw e;
        }
]]></xsl:text>
    <xsl:if test="$useQosProfile = 'no'">
        /* To customize topic QoS, use
           participant.get_default_topic_qos() */
    </xsl:if>
    <xsl:if test="$useQosProfile = 'yes'">
        /* To customize topic QoS, use 
           the configuration file USER_QOS_PROFILES.xml */
    </xsl:if>
<xsl:text><![CDATA[    DDS.Topic topic = participant.create_topic(
            "Example %%nativeType%%",
            type_name,
            DDS.DomainParticipant.TOPIC_QOS_DEFAULT,
            null /* listener */,
            DDS.StatusMask.STATUS_MASK_NONE);
        if (topic == null) {
            shutdown(participant);
            throw new ApplicationException("create_topic error");
        }

        // --- Create writer --- //
]]></xsl:text>
    <xsl:if test="$useQosProfile = 'no'">
        /* To customize data writer QoS, use
            publisher.get_default_datawriter_qos() */
    </xsl:if>
    <xsl:if test="$useQosProfile = 'yes'">
        /* To customize data writer QoS, use 
           the configuration file USER_QOS_PROFILES.xml */
    </xsl:if>
<xsl:text><![CDATA[    DDS.DataWriter writer = publisher.create_datawriter(
            topic,
            DDS.Publisher.DATAWRITER_QOS_DEFAULT,
            null /* listener */,
            DDS.StatusMask.STATUS_MASK_NONE);
        if (writer == null) {
            shutdown(participant);
            throw new ApplicationException("create_datawriter error");
        }
        %%nativeType%%DataWriter %%nativeType%%_writer =
            (%%nativeType%%DataWriter)writer;

        // --- Write --- //

        /* Create data sample for writing */
        %%nativeType%% instance = %%nativeType%%TypeSupport.create_data();
        if (instance == null) {
            shutdown(participant);
            throw new ApplicationException(
                "%%nativeType%%TypeSupport.create_data error");
        }

        /* For a data type that has a key, if the same instance is going to be
           written multiple times, initialize the key here
           and register the keyed instance prior to writing */
        DDS.InstanceHandle_t instance_handle = DDS.InstanceHandle_t.HANDLE_NIL;
        /*
        instance_handle = %%nativeType%%_writer.register_instance(instance);
        */

        /* Main loop */
        const System.Int32 send_period = 4000; // milliseconds
        for (int count=0;
             (sample_count == 0) || (count < sample_count);
             ++count) {
            Console.WriteLine("Writing %%nativeType%%, count {0}", count);

            /* Modify the data to be sent here */
            %%modifyPubData%%

            try {
                %%nativeType%%_writer.write(instance, ref instance_handle);
            }
            catch(DDS.Exception e) {
                Console.WriteLine("write error {0}", e);
            }

            System.Threading.Thread.Sleep(send_period);
        }

        /*
        try {
            %%nativeType%%_writer.unregister_instance(
                instance, ref instance_handle);
        } catch(DDS.Exception e) {
            Console.WriteLine("unregister instance error: {0}", e);
        }
        */

        // --- Shutdown --- //

        /* Delete data sample */
        try {
            %%nativeType%%TypeSupport.delete_data(instance);
        } catch(DDS.Exception e) {
            Console.WriteLine(
                "%%nativeType%%TypeSupport.delete_data error: {0}", e);
        }

        /* Delete all entities */
        shutdown(participant);
    }

    static void shutdown(
        DDS.DomainParticipant participant) {

        /* Delete all entities */

        if (participant != null) {
            participant.delete_contained_entities();
            DDS.DomainParticipantFactory.get_instance().delete_participant(
                ref participant);
        }

        /* %%coreProduct%% provides finalize_instance() method on
           domain participant factory for people who want to release memory
           used by the participant factory. Uncomment the following block of
           code for clean destruction of the singleton. */
        /*
        try {
            DDS.DomainParticipantFactory.finalize_instance();
        } catch (DDS.Exception e) {
            Console.WriteLine("finalize_instance error: {0}", e);
            throw e;
        }
        */
    }
}

]]></xsl:text>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:if>
</xsl:template>


<!-- ===================================================================== -->
<!-- Directives                                                            -->
<!-- ===================================================================== -->

<!--
Process directives

We ignore the copy directives for the example code
-->
<xsl:template match="directive[@kind = 'copy' or @kind = 'copy-cppcli']"/>

<xsl:template match="directive[@kind = 'copy' or @kind = 'copy-cppcli']"
              mode="code-generation"/>

</xsl:stylesheet>