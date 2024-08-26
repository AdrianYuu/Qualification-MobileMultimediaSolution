//
//  PageDestination.swift
//  ThreAdY
//
//  Created by Adrian Yu on 21/08/24.
//

import Foundation

enum PageDestination {
    case login
    case register
    case home
    case createPost
    case updatePost(post: Post)
    case profile
}
