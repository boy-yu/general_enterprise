/*
 * Copyright 2013 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.gradle.tooling.internal.protocol;

/**
 * A wrapper thrown when a build action fails with an exception. The failure will be attached as the cause of this exception.
 *
 * DO NOT CHANGE THIS CLASS. It is part of the cross-version protocol.
 *
 * @since 1.8-rc-1
 */
public class InternalBuildActionFailureException extends RuntimeException {
    public InternalBuildActionFailureException(Throwable cause) {
        super(cause);
    }
}
