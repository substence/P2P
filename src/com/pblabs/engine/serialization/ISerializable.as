/*******************************************************************************
 * PushButton Engine
 * Copyright (C) 2009 PushButton Labs, LLC
 * For more information see http://www.pushbuttonengine.com
 * 
 * This file is licensed under the terms of the MIT license, which is included
 * in the License.html file at the root directory of this SDK.
 ******************************************************************************/
package com.pblabs.engine.serialization
{
   /**
    * Provides an interface for objects to override the default serialization
    * behavior.
    * 
    * <p>Any class implementing this interface will automatically have its
    * serialize and deserialize methods called in place of the default serialization
    * methods on the Serializer class.</p>
    * 
    * @see Serializer
    * @see ../../../../../Examples/CustomSerialization.html Custom Serialization
    */
   public interface ISerializable
   {
      /**
       * serializes the object to XML. This should not include the main tag
       * defining the class itself.
       * 
       * @param xml The xml object to which the serialization of this class should
       * be added. This xml object is a single tag containing the main class definition,
       * so only children of this class should be added to it.
       * 
       * @see ../../../../../Examples/SerializingObjects.html Serializing Objects
       */
      function serialize(xml:XML):void;
      
      /**
       * deserializes the object from xml. The format of the xml passed is custom,
       * depending on the way the object was serialized with the serialize method.
       * 
       * @param xml The xml containing the serialized definition of the class.
       * 
       * @return The deserialized object. Usually 'this' should be returned, but in
       * some cases it may be useful to return something else. The Enumerable class
       * does this to force all values to be a member of the enumeration.
       * 
       * @see ../../../../../Examples/DeserializingObjects.html Deserializing Objects
       */
      function deserialize(xml:XML):*;
   }
}