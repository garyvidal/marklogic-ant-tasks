package com.marklogic.ant.taskdefs;

import java.util.Vector;

import org.apache.tools.ant.types.DataType;

import com.marklogic.xcc.ContentPermission;

public class PermissionSet extends DataType {
	
	private Vector<ContentPermission> permissions = new Vector<ContentPermission>();
	
	public void addConfiguredPermission(Permission perm) {
		ContentPermission contentPerm = null;
		if( perm.getPermission().equals(Permission.Capability.execute) ) {
			
			contentPerm = ContentPermission.newExecutePermission(perm.getRole());
			
		} else if ( perm.getPermission().equals(Permission.Capability.insert) ) {
			
			contentPerm = ContentPermission.newInsertPermission(perm.getRole());
			
		} else if ( perm.getPermission().equals(Permission.Capability.read) ) {
			
			contentPerm = ContentPermission.newReadPermission(perm.getRole());
			
		} else if ( perm.getPermission().equals(Permission.Capability.update) ) {
			
			contentPerm = ContentPermission.newUpdatePermission(perm.getRole());
			
		}

		if (!permissions.contains(contentPerm)) {
			permissions.add(contentPerm);
		}
	}
	
	public ContentPermission[] getPermissions() {
		ContentPermission[] perms = new ContentPermission[permissions.size()];
		return permissions.toArray(perms);
	}

}
